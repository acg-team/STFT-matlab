function coords = get_cx2(centers,ck,L)

N = size(centers,1);

coords=zeros(N,4);

I=1:L;

for i=1:N

    idx=circshift(I,ck(i));

    a=idx(centers(i,1));
    b=idx(centers(i,2));
    
    c=centers(i,1);
    d=centers(i,2);
  
    coords(i,:)=[a,b,c,d];
    
end