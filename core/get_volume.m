function v=get_volume(seq,mapObj)

volume=load_volume();

[h,w]=size(seq);
v=zeros(h,w);
for i=1:h
    for j=1:w
        ch=seq(i,j);
        v(i,j)=volume(mapObj(ch));
    end
end
