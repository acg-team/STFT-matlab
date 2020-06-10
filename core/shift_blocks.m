function [s1,s2,w12]=shift_blocks(seq1,seq2,centers,ck)

l12=size(seq1,2);
l22=size(seq2,2);

if l12 ~= l22
    error('ERROR shift_blocks')
end

L=l12;

if centers(1)-ck > 0
    range=centers(1)-ck:centers(2)-ck;
else
    range=centers(1)-ck+L:centers(2)-ck+L;
    range(range>L)=[];
end

w1=false(1,L);
w1(range)=true;

w2=false(1,L);
w2(centers(1):centers(2))=true;

s1=seq1;
s2=seq2;

w2=circshift(w2,-ck);
w12 = (w1 & w2);

for i=1:size(s2,1)
    stemp=s2(i,:);
    stemp=circshift(stemp,-ck);
    s2(i,:)=stemp;
end
%%
for i=1:L    
    if not(w12(i))
        s1(:,i)='.';
        s2(:,i)='.';
    end
end
