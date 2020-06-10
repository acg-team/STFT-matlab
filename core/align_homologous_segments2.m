function [traceback_cell,segments_cell,LK,TOT]=align_homologous_segments2(node,coords,seq1,seq2,params)

num_segments=size(coords,1);

traceback_cell=cell(num_segments,1);
segments_cell=cell(num_segments,1);

TOT=0;
LK=0;
%parfor k=1:num_segments
for k=1:num_segments

    %----------------------   
    a1=coords(k,1);
    b1=coords(k,2);
    a2=coords(k,3);
    b2=coords(k,4);
    
    seg1=seq1(:,a1:b1);
    seg2=seq2(:,a2:b2);
    %----------------------    
    
    segments_cell{k}.seg1=seg1;
    segments_cell{k}.seg2=seg2;
       
    display('.................')
    seg1
    seg2
    display('----------------')
    
    if node.Left.is_leaf && node.Right.is_leaf
        [traceback_cell{k}.tr,LK,tot]=DP_leaves(node,seg1,seg2,params);
    else
        [traceback_cell{k}.tr,LK,tot]=DP_MSA(node,seg1,seg2,params);
    end
    
    TOT=TOT+tot;
end