function [v1,v2,p1,p2,c1,c2]=dim_reduce_AA(v1,v2,p1,p2,c1,c2)

v1=mean(v1,1);
v2=mean(v2,1);

p1=mean(p1,1);
p2=mean(p2,1);

c1=mean(c1,1);
c2=mean(c2,1);