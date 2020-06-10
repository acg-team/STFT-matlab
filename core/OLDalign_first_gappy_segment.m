function [gappy_traceback_cell,LK,TOT,gappy_traceback_cell_vector]=align_first_gappy_segment(node,traceback_cell,segments_cell,jarray,seq1,seq2,l1,l2,params,P)

len=max([l1,l2]);

MATCH=1;
GAPX=2;
GAPY=3;

TOT=0;
LK=0;

if params.SB==1
    gappy_traceback_cell_vector=cell(params.num_SB,1);
else
    gappy_traceback_cell_vector=[];
end

gappy_traceback_cell=cell(1,1);

if jarray(1,1)+jarray(1,4) > 2 %controllare che valga per corr e grantham
    
    seg1=segments_cell{1}.seg1;
    seg2=segments_cell{1}.seg2;
    
    tr=traceback_cell{1}.tr;
    
    gappy_MSA_left_1=[];
    gappy_MSA_left_2=[];
    gappy_MSA_right_1=[];
    gappy_MSA_right_2=[];
    
    c_s1=1;
    c_s2=1;
    i_tr=1;
    while i_tr<=length(tr) && c_s1<=size(seg1,2) && c_s2<=size(seg2,2) && tr(i_tr)~=MATCH
        T=tr(i_tr);
        switch(T)
            case 1
                % should be never the case
                break
            case 2
                gappy_MSA_right_1=[gappy_MSA_right_1,seg1(:,c_s1)];
                c_s1=c_s1+1;
            case 3
                gappy_MSA_right_2=[gappy_MSA_right_2,seg2(:,c_s2)];
                c_s2=c_s2+1;
        end
        i_tr=i_tr+1;
    end
    
    traceback_cell{1}.tr=tr(i_tr:end);
    
    [gr1,gr2,tr]=search_first_match(seg1,seg2,tr)
    
    
    
    if strcmp(params.homologous_approach,'correlation')
        a=1;
        b=jarray(1,1)-1;
        gappy_s1=[gappy_MSA_left_1,seq1(:,a:b),gappy_MSA_right_1];
        
        a=1+l1;
        b=(jarray(1,1)-1)+(jarray(1,4)-1);
        gappy_s2=[gappy_MSA_left_2,seq2(:,a:b),gappy_MSA_right_2];
   
    elseif strcmp(params.homologous_approach,'grantham')
        
        lag_k=jarray(1,4);
        
        a=1;
        b=jarray(1,1)-1;
        if b>0
            s1=seq1(:,a:b);
        else
            s1=[];
        end
        gappy_s1=[gappy_MSA_left_1,s1,gappy_MSA_right_1];
        
        side=jarray(1,5);
        if side==1
            a2l=a+lag_k;
            b2l=b+lag_k;
            if a2l>0 && b2l>0 && a2l<=len && b2l<=len  
                s2=seq2(a2l:b2l);
            else
                s2=[];
            end
        else
            a2r=a-(len-lag_k);
            b2r=b-(len-lag_k);
            if a2r>0 && b2r>0 && a2r<=len && b2r<=len
                s2=seq2(a2r:b2r);
            else
                s2=[];
            end
        end
        gappy_s2=[gappy_MSA_left_2,s2,gappy_MSA_right_2];
    end
    
    
    
    
    
    
    
    if isempty(gappy_s1) && isempty(gappy_s2)
        gappy_traceback_cell{1}.tr=[];
        return;
    end
    
    if isempty(gappy_s1)
        gappy_traceback_cell{1}.tr=repmat(GAPY,[1,size(gappy_s2,2)]);
        return
    end
    if isempty(gappy_s2)
        gappy_traceback_cell{1}.tr=repmat(GAPX,[1,size(gappy_s1,2)]);
        return
    end
    
    if params.SB==0
        
        if node.Left.is_leaf && node.Right.is_leaf            
            [gappy_traceback_cell{1}.tr,LK,TOT]=DP_leaves(node,gappy_s1,gappy_s2,params,P);
        else
            [gappy_traceback_cell{1}.tr,LK,TOT]=DP_MSA(node,gappy_s1,gappy_s2,params);
        end
        
    else
        
        if node.Left.is_leaf && node.Right.is_leaf            
            [gappy_traceback_cell,gappy_traceback_cell_vector]=SB_DP_leaves(gappy_s1,gappy_s2,params,P);
        else
            %TODO SB for MSA
        end
        
    end
    
else
    gappy_traceback_cell{1}.tr=[];
end

