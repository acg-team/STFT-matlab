function [gappy_traceback_cell,traceback_cell,LK,TOT,gappy_traceback_cell_vector]=align_intermediate_gappy_segment(node,traceback_cell,segments_cell,jarray,seq1,seq2,l1,l2,params,P)

len=max([l1,l2]);

MATCH=1;
GAPX=2;
GAPY=3;

num_segments=size(jarray,1);

TOT=0;
LK=0;

if params.SB==1
    gappy_traceback_cell_vector=cell(num_segments-1,params.num_SB);
else
    gappy_traceback_cell_vector=[];
end

if num_segments==1
    gappy_traceback_cell{1}.tr=[];
    return
end

gappy_traceback_cell=cell(num_segments-1,1);

for k=1:num_segments-1
    
    %%--------------------------------------------
    seg1=segments_cell{k}.seg1;
    seg2=segments_cell{k}.seg2;
    tr=traceback_cell{k}.tr;
    [gl1,gl2,tr]=search_last_match(seg1,seg2,tr);
    traceback_cell{k}.tr=tr;
    %%--------------------------------------------
    seg1=segments_cell{k+1}.seg1;
    seg2=segments_cell{k+1}.seg2;
    tr=traceback_cell{k+1}.tr;
    [gr1,gr2,tr]=search_first_match(seg1,seg2,tr);
    traceback_cell{k+1}.tr=tr;
    %%--------------------------------------------
    
    [gappy_s1,gappy_s2]=get_gappy_segments(seq1,seq2,gl1,gr1,gl2,gr2,'intermediate',jarray(k,:),jarray(k+1,:),len,params,l1,l2);
    
    display('align_intermediate_gappy_segment')
    gappy_s1
    gappy_s2
    
    
    if isempty(gappy_s1) && isempty(gappy_s2)
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
            if node.Left.is_leaf && node.Right.is_leaf
                gappy_traceback_cell_vector_k=SB_DP_leaves(gappy_s1,gappy_s2,params,P);
                gappy_traceback_cell_vector{k}=gappy_traceback_cell_vector_k;
                gappy_traceback_cell{1}.tr=gappy_traceback_cell_vector_k{1}.tr;
            else
                %TODO SB for MSA
            end
            tot=0;
        end
        
        TOT=TOT+tot;
    end
end