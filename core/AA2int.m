function mat=AA2int(seq,mapObj)

[h,w]=size(seq);
mat=zeros(h,w);
for i=1:h
    for j=1:w
        ch=seq(i,j);
        mat(i,j)=mapObj(ch);
    end
end
