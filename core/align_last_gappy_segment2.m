function [gappy_traceback_cell,traceback_cell,segments_cell,LK,TOT,gappy_traceback_cell_vector]=align_last_gappy_segment2(node,traceback_cell,segments_cell,coords,seq1,seq2,l1,l2,params)

len=max([l1,l2]);

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

if coords(end,2)< l1 || coords(end,4)< l1+l2
    
    %------------------------------------------------------------
    seg1=segments_cell{end}.seg1;
    seg2=segments_cell{end}.seg2;
    tr=traceback_cell{end}.tr;
    
    %[gl1,gl2,tr,seg1,seg2]=search_last_match2(seg1,seg2,tr);
    [gl1,gl2,tr,seg1,seg2]=search_last_match3(seg1,seg2,tr,params.consMatch);
    
    segments_cell{end}.seg1=seg1;
    segments_cell{end}.seg2=seg2;
    traceback_cell{end}.tr=tr;
    %------------------------------------------------------------
    
    gr1=[];
    gr2=[];
    [gappy_s1,gappy_s2]=get_gappy_segments2(seq1,seq2,gl1,gr1,gl2,gr2,'last',[],coords(end,:),len,params,l1,l2);
    
    if isempty(gappy_s1) && isempty(gappy_s2)
        gappy_traceback_cell{1}.tr=[];
    elseif isempty(gappy_s1)
        gappy_traceback_cell{1}.tr=repmat(GAPY,[1,size(gappy_s2,2)]);
    elseif isempty(gappy_s2)
        gappy_traceback_cell{1}.tr=repmat(GAPX,[1,size(gappy_s1,2)]);
    else
        
        if params.SB==0
                       
            if node.Left.is_leaf && node.Right.is_leaf
                [gappy_traceback_cell{1}.tr,LK,TOT]=DP_leaves(node,gappy_s1,gappy_s2,params);
            else
                [gappy_traceback_cell{1}.tr,LK,TOT]=DP_MSA(node,gappy_s1,gappy_s2,params);
            end
            
        else
            
            if node.Left.is_leaf && node.Right.is_leaf
                gappy_traceback_cell_vector=SB_DP_leaves(gappy_s1,gappy_s2,params);
                gappy_traceback_cell{1}.tr=gappy_traceback_cell_vector{1}.tr;
            else
                %TODO SB for MSA
            end
            
        end
        
    end
    
else
    
    gappy_traceback_cell{1}.tr=[];
    
end