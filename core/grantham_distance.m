function d=grantham_distance(seq1,seq2,map,G_table)

N=length(seq1);

d=zeros(1,N);

for i=1:N
    ch1=seq1(i);
    ch2=seq2(i);
    
    idx_1=map(ch1);
    idx_2=map(ch2);
    
    d(i)=G_table(idx_1,idx_2);
end