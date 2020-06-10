function [s1,s2,a,b]=shift_blocks2(seq1,seq2,centers,ck)

l12=size(seq1,2);
l22=size(seq2,2);

if l12 ~= l22
    error('ERROR shift_blocks')
end

L=l12;

idx=1:L;

idx=circshift(idx,ck);

a=idx(centers(1));
b=idx(centers(2));

bool=false(1,L);
bool(a:b)=true;
%%
s1=seq1;
s2=seq2;

for i=1:size(s2,1)
    stemp=s2(i,:);
    stemp=circshift(stemp,-ck);
    s2(i,:)=stemp;
end
%%
for i=1:L    
    if not(bool(i))
        s1(:,i)='.';
        s2(:,i)='.';
    end
end