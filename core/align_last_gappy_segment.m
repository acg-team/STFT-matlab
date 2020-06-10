function [gappy_traceback_cell,traceback_cell,LK,TOT,gappy_traceback_cell_vector]=align_last_gappy_segment(node,traceback_cell,segments_cell,jarray,seq1,seq2,l1,l2,params,P)

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

if (jarray(end,2) < size(seq1,2)) || (jarray(end,2)+jarray(end,4)-1 < size(seq2,2)) %controllare che valga per corr e grantham
    
    gr1=[];
    gr2=[];
    %%--------------------------------------------
    seg1=segments_cell{end}.seg1;
    seg2=segments_cell{end}.seg2;
    tr=traceback_cell{end}.tr;
    
    display('prima')
    tr
    
    [gl1,gl2,tr]=search_last_match(seg1,seg2,tr);
    traceback_cell{end}.tr=tr;
    
    display('dopo')
    tr
    
    gl1
    gl2
    %%--------------------------------------------
    
    [gappy_s1,gappy_s2]=get_gappy_segments(seq1,seq2,gl1,gr1,gl2,gr2,'last',[],jarray(end,:),len,params,l1,l2);
    
    
    display('align_last_gappy_segment')
    gappy_s1
    gappy_s2
    
%     gr1
%     gr2
%     gl1
%     gl2
%     gappy_s1
%     gappy_s2
%     stop()
    
    
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
            gappy_traceback_cell_vector=SB_DP_leaves(gappy_s1,gappy_s2,params,P);
            gappy_traceback_cell{1}.tr=gappy_traceback_cell_vector{1}.tr;
        else
            %TODO SB for MSA
        end
        
    end

else
    gappy_traceback_cell{1}.tr=[];
end