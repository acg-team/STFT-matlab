function [lk_v]=score_segment(shift_seq1,shift_seq2,params)

extended_alphabet_size=params.extended_alphabet_size;
map=params.map;
bl1=params.bl(1);
bl2=params.bl(2);
Q=params.Q;
Pi=params.Pi;
iotaV0=params.iotas(1);
betaV0=params.betas(1);

seqs_len=length(shift_seq1);

lk_v=zeros(1,seqs_len);
for c=1:seqs_len
    col_i=shift_seq1(c);
    col_j=shift_seq2(c);
    
    fv1=zeros(extended_alphabet_size,1);
    fv1(map(col_i))=1;
    fv2=zeros(extended_alphabet_size,1);
    fv2(map(col_j))=1;
    
    fv0=expm(bl1*Q)*fv1.*expm(bl2*Q)*fv2;
    lk_v(c)=iotaV0*betaV0*sum(Pi.*fv0);  
end