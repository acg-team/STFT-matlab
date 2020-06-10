function [shift_seq1,shift_seq2,offset]=shift_sequences_lag(seq1,seq2,lag_k,l1,l2)

[a1,b1,a2,b2]=get_bound_segments(lag_k,l1,l2);

if b1<a1
    shift_seq1=[];
else
    shift_seq1=seq1(:,a1:b1);
end

if b2<a2
    shift_seq2=[];
else
    shift_seq2=seq2(:,a2:b2);
end

offset=a1-1;






