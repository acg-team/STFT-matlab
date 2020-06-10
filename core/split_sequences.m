function [b1l,b2l,b1r,b2r]=split_sequences(shift_seq1,shift_seq2,lag_k,l)

b1l=shift_seq1(1:l-lag_k);
b2l=shift_seq2(1:l-lag_k);
b1r=shift_seq1(l-lag_k+1:l);
b2r=shift_seq2(l-lag_k+1:l);

