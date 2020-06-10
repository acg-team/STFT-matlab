function p=expand(p,X,Y,coord)

len=length(X);

p_last=p(end);

p=[];

xi=X(p_last);
yi=Y(p_last);
cx=coord(xi,1);
cy=coord(yi,1);

while p_last<=len
    
    p_last=p_last+1;
    
    xi=X(p_last);
    yi=Y(p_last);
    ncx=coord(xi,1);
    ncy=coord(yi,1);
    
    if ncx>cx && ncy>cy
        p=p_last+1;
        break;
    end
    
end


