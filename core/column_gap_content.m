function sig=column_gap_content(shift_seq1,shift_seq2)

msa_t=[shift_seq1;shift_seq2];

nseqs=size(msa_t,1);
ncolumns=size(msa_t,2);

sig=zeros(1,ncolumns);

for i=1:ncolumns
   sig(i)=sum(msa_t(:,i) ~= '-')/nseqs;
end

%%
% msa_t
% 
% figure
% %plot(sig,'.k--')
% stairs(sig)
% ylim([0,1.1])
% xlim([1,size(msa_t,2)])
% stop()