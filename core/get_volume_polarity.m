function [v,p,c]=get_volume_polarity(seq,mapObj)

[volume,polarity,composition]=load_volume_polarity();

[h,w]=size(seq);
v=zeros(h,w);
p=zeros(h,w);
c=zeros(h,w);
for i=1:h
    for j=1:w
        ch=seq(i,j);
        v(i,j)=volume(mapObj(ch));
        p(i,j)=polarity(mapObj(ch));
        c(i,j)=composition(mapObj(ch));
    end
end
