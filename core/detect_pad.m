function sig = detect_pad(s1,s2,sig)

msa=[s1;s2];

for i=1:size(msa,2)
   
    col=msa(:,i);
    
    if sum(col==' ')>0
       sig(i)=0;
    end
    
end
