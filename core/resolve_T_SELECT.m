function [H,choice]=resolve_T_SELECT(a1,b1,a2,b2,c1,d1,c2,d2)

S1=[a1,b1,a2,b2];
S2=[c1,d1,c2,d2];

S1=check_is_square(S1);
S2=check_is_square(S2);

h1 = S1(2)-S1(1)+1;
w1 = S1(4)-S1(3)+1;
h2 = S2(2)-S2(1)+1;
w2 = S2(4)-S2(3)+1;

s1=sqrt(h1*w1);
s2=sqrt(h2*w2);

if s1>=s2
    %H=[a1,b1,a2,b2];
    H=S1;
    choice=1;
else
    %H=[c1,d1,c2,d2];
    H=S2;
    choice=2;
end
