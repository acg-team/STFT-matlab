function [gappy_traceback_cell,LK,TOT,gappy_traceback_cell_vector]=align_intermediate_gappy_segment(node,traceback_cell,segments_cell,jarray,seq1,seq2,l1,l2,params,P,COMPUTE_NUM_CELLS)

MATCH=1;
GAPX=2;
GAPY=3;

num_segments=size(jarray,1);

TOT=0;
LK=0;

if num_segments-1 <1
    gappy_traceback_cell{1}.tr=[];
    return
end

if params.SB==1
    gappy_traceback_cell_vector=cell(num_segments-1,params.num_SB);
else
    gappy_traceback_cell_vector=[];
end

gappy_traceback_cell=cell(num_segments-1,1);

for k=1:num_segments-1
    
    seg1=segments_cell{k}.seg1;
    seg2=segments_cell{k}.seg2;
    
    tr=traceback_cell{k}.tr;
    
%     gappy_MSA_left_1=[];
%     gappy_MSA_left_2=[];
%     gappy_MSA_right_1=[];
%     gappy_MSA_right_2=[];
%     
%     c_s1=length(seg1);
%     c_s2=length(seg2);
%     i_tr=length(tr);
%     while i_tr>1 && c_s1>1 && c_s2>1 && tr1(i_tr)~=MATCH
%         T=tr(i_tr);
%         switch(T)
%             case 1
%                 % should be never the case
%                 break
%             case 2
%                 gappy_MSA_left_1=[seg1(:,c_s1),gappy_MSA_left_1];
%                 c_s1=c_s1-1;
%             case 3
%                 gappy_MSA_left_2=[seg2(:,c_s2),gappy_MSA_left_2];
%                 c_s2=c_s2-1;
%         end
%         i_tr=i_tr-1;
%     end
%traceback_cell{k}.tr=tr(1:i_tr);    

    [gl1,gl2,tr]=search_last_match(seg1,seg2,tr);

    traceback_cell{k}.tr=tr;
    
    seg1=segments_cell{k+1}.seg1;
    seg2=segments_cell{k+1}.seg2;
    
    tr=traceback_cell{k+1}.tr;
    
%     c_s1=1;
%     c_s2=1;
%     i_tr2=1;
%     gappy_MSA_right=[];
%     while i_tr2<=length(tr2) && c_s1<=size(seg1,2) && c_s2<=size(seg2,2) && tr2(i_tr2)~=MATCH
%         T=tr2(i_tr2);
%         switch(T)
%             case 1
%                 % should be never the case
%                 break
%             case 2
%                 gappy_MSA_right_1=[gappy_MSA_right_1,seg1(:,c_s1)];
%                 c_s1=c_s1+1;
%             case 3
%                 gappy_MSA_right_2=[gappy_MSA_right_2,seg2(:,c_s2)];
%                 c_s2=c_s2+1;
%         end
%         i_tr2=i_tr2+1;
%     end
%     
%     traceback_cell{k+1}.tr=traceback_cell{k+1}.tr(i_tr2:end);
    
    [gr1,gr2,tr]=search_first_match(seg1,seg2,tr);
    
    traceback_cell{k+1}.tr=tr;
    
    if strcmp(params.homologous_approach,'correlation')
        
        a=jarray(k,2)+1;
        b=jarray(k+1,1)-1;
        gappy_s1=[gl1,seq1(:,a:b),gr1];
        
        a=jarray(k,2)+jarray(k,4);
        b=(jarray(k+1,1)-1)+(jarray(k+1,4)-1);
        
        gappy_s2=[gl2,seq2(:,a:b),gr2];
        
    elseif strcmp(params.homologous_approach,'grantham')
        
        %         lag_k=jarray(k,4);
        %
        %         a=1;
        %         b=jarray(1,1)-1;
        %         if b>0
        %             s1=seq1(:,a:b);
        %         else
        %             s1=[];
        %         end
        %         gappy_s1=[gappy_MSA_left_1,s1,gappy_MSA_right_1];
        %
        %         side=jarray(1,5);
        %         if side==1
        %             a2l=a+lag_k;
        %             b2l=b+lag_k;
        %             if a2l>0 && b2l>0 && a2l<=len && b2l<=len
        %                 s2=seq2(a2l:b2l);
        %             else
        %                 s2=[];
        %             end
        %         else
        %             a2r=a-(len-lag_k);
        %             b2r=b-(len-lag_k);
        %             if a2r>0 && b2r>0 && a2r<=len && b2r<=len
        %                 s2=seq2(a2r:b2r);
        %             else
        %                 s2=[];
        %             end
        %         end
        %         gappy_s2=[gappy_MSA_left_2,s2,gappy_MSA_right_2];
    end
    
    
    if isempty(gappy_s1) && isempty(gappy_s1)
        gappy_traceback_cell{k}=[];
        TOT=0;
        LK=0;
    elseif isempty(gappy_s1)
        gappy_traceback_cell{k}.tr=repmat(GAPY,[1,size(gappy_s2,2)]);
        TOT=0;
        LK=0;
    elseif isempty(gappy_s2)
        gappy_traceback_cell{k}.tr=repmat(GAPX,[1,size(gappy_s1,2)]);
        TOT=0;
        LK=0;
    else
        
        if params.SB==0
            if node.Left.is_leaf && node.Right.is_leaf
                [gappy_traceback_cell{k}.tr,LK,tot]=DP_leaves(node,gappy_s1,gappy_s2,params,P);
            else
                [gappy_traceback_cell{k}.tr,LK,tot]=DP_MSA(node,gappy_s1,gappy_s2,params);
            end
        else
            for sb=1:params.num_SB
                gappy_traceback_cell{k}.tr=SB_DP_leaves(gappy_s1,gappy_s2,params,P);
                gappy_traceback_cell_vector{k,sb}.tr=gappy_traceback_cell{k}.tr;
                h=length(gappy_s1+1);
                w=length(gappy_s2+1);
                d=(h-1)+(w-1)+1;
                gappy_traceback_cell_vector{k,sb}.dim=[h,w,d];
            end
            tot=0;
        end
        
        TOT=TOT+tot;
    end
end