function d=compute_grantham_distance(shift_seq1,shift_seq2,params,G_table)

N=length(shift_seq1);
map=params.map;

d=zeros(N,1);

for k=1:N
   ch1=shift_seq1(k);
   ch2=shift_seq2(k);
   d(k)=grantham_distance(ch1,ch2,map,G_table);
end


