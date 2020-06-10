function type=overlap_type(a1,b1,a2,b2,c1,d1,c2,d2)

if (c1>=b1) && (c2>=b2)
    type='normal';
elseif a1==c1 && b1==d1 && a2==c2 && b2==d2
    type='identical';
elseif a1<=c1 && b1>=d1 && a2<=c2 && b2>=d2
    type='insideI';
elseif a1>=c1 && b1<=d1 && a2>=c2 && b2<=d2
    type='insideII';
elseif(c1<b1 && c2<b2 && d2>b2 && d1>b1)
    type='overlapI';
elseif (c1<b1 && d1>b1 && c2>b2 && d2>b2)
    type='overlapX';
elseif (c1>b1 && d1>b1 && c2<b2 && d2>b2)
    type='overlapY';
elseif (c1>a1 && d1>b1 && (c2==a2 || d2==b2))
    type='edgeX';
elseif (c2>a2 && d2>b2 && (c1==a1 || d1==b1))
    type='edgeY';
elseif (c1>=a1 && d1<=b1 && c2>b2)
    type='selectX';
elseif (c2>=a2 && d2<=b2 && c1>b1)
    type='selectY';
elseif (c1>=a1 && d1<=b1 && d2>=b2)
    type='insideXI';
elseif (c1>=a1 && d1<=b1 && c2<=a2)
    type='insideXII'; 
elseif (c1<=a1 && d1>=b1 && d2<=b2)
    type='insideXIII';    
elseif (c1<=a1 && d1>=b1 && c2>=a2)
    type='insideXIV';    
elseif (c2>=a2 && d2<=b2 && c1<=a1)
    type='insideYI';   
elseif (c2>=a2 && d2<=b2 && d1>=b1)
    type='insideYII'; 
elseif (c2<=a2 && d2>=b2 && c1>=a1)
    type='insideYIII';
elseif (c2<=a2 && d2>=b2 && d1<=b1)
    type='insideYIV';   
else
    
    %     fid=fopen('OVERLAP','w');
    %     fprintf(fid,'a1 %d; b1 %d; a2 %d; b2 %d; c1 %d; d1 %d; c2 %d; d2 %d\n',a1,b1,a2,b2,c1,d1,c2,d2);
    %     fclose(fid);
    
    
    type='error';
end