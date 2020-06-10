function c=get_composition(seq,mapObj)

composition=load_composition();

[h,w]=size(seq);
c=zeros(h,w);
for i=1:h
    for j=1:w
        ch=seq(i,j);
        c(i,j)=composition(mapObj(ch));
    end
end