function H=resolve_T_OVERLAP(a1,b1,a2,b2,c1,d1,c2,d2)

delta=min([c1-a1,c2-a2]);
diag_x1=a1+delta;
diag_y1=a2+delta;

delta=min([d1-b1,d2-b2]);
diag_x2=d1-delta;
diag_y2=d2-delta;

h1=[a1,diag_x1-1,a2,diag_y1-1];
h2=[diag_x1,diag_x2,diag_y1,diag_y2];
h3=[diag_x2+1,d1,diag_y2+1,d2];

H=[h1;h3];