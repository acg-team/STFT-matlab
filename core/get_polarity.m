function p=get_polarity(seq,mapObj)

polarity=load_polarity();

[h,w]=size(seq);
p=zeros(h,w);
for i=1:h
    for j=1:w
        ch=seq(i,j);
        p(i,j)=polarity(mapObj(ch));
    end
end