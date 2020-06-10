function [traceback_cell,segments_cell,LK,TOT]=align_homologous_segments(node,jarray,seq1,seq2,params,P,l1,l2)

num_segments=size(jarray,1);
traceback_cell=cell(num_segments,1);
segments_cell=cell(num_segments,1);

TOT=0;
LK=0;
%parfor k=1:num_segments
for k=1:num_segments
    %-------------------------------------------------------
    %lag_k=jarray(k,4);
    %[seg1,seg2]=shift_sequences_lag(seq1,seq2,lag_k,l1,l2);
    %-------------------------------------------------------
%     lag_k=jarray(k,4);
%     a=jarray(k,1);
%     b=jarray(k,2);
%     [shift_seq1,shift_seq2]=shift_sequences_lag(seq1,seq2,lag_k,l1,l2);    
%     seg1=shift_seq1(:,a:b);
%     seg2=shift_seq2(:,a:b);
    %-------------------------------------------------------
    a1=jarray(k,1);
    b1=jarray(k,2);

    a2=a1+jarray(k,4)-1;
    b2=b1+jarray(k,4)-1;
    
    whos seq1
    whos seq2
    [l1,l2]
    [a1,b1,a2,b2]
    
    seg1=seq1(:,a1:b1);
    seg2=seq2(:,a2:b2);
    
    display('ss1.ss2')
    [seg1;
    seg2]
    %-------------------------------------------------------
    
    
    segments_cell{k}.seg1=seg1;
    segments_cell{k}.seg2=seg2;
       
    if node.Left.is_leaf && node.Right.is_leaf
        [traceback_cell{k}.tr,LK,tot]=DP_leaves(node,seg1,seg2,params,P);
    else
        [traceback_cell{k}.tr,LK,tot]=DP_MSA(node,seg1,seg2,params);
    end
    
    TOT=TOT+tot;
end