function [H,choice]=resolve_T_EDGE(a1,b1,a2,b2,c1,d1,c2,d2)

if a1==c1 && a2==c2 && b1==d1 && b2==d2

    H=[a1,b1,a2,b2];
    choice = 5;
    
else
    
    a1=min([a1,c1]);
    b1=max([b1,d1]);
    a2=min([a2,c2]);
    b2=max([b2,d2]);
    
    H=[a1,b1,a2,b2];
    choice = 3;
    
end
