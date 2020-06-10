function coords = get_cx(centers,ck,L)

N =size(centers,1);

coords=zeros(N,4);

for i=1:N
    
    if centers(i,1)-ck(i) > 0
        a=centers(i,1)-ck(i);
        b=centers(i,2)-ck(i);
    else
        a=L-ck(i)+centers(i,1);
        b=L-ck(i)+centers(i,2);  
        if a>L
            a=L;
        end
        if b>L
            b=L;
        end
    end
    
    c=centers(i,1);
    d=centers(i,2);
  
    coords(i,:)=[a,b,c,d];
    
end