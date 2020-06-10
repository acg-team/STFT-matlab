function G = compute_grantham_match(s1,s2,params)

alpha=1.833;
beta=0.1018;
gamma=0.000399;

v1=get_volume(s1,params.map);
p1=get_polarity(s1,params.map);
c1=get_composition(s1,params.map);

v2=get_volume(s2,params.map);
p2=get_polarity(s2,params.map);
c2=get_composition(s2,params.map);

v1=mean(v1,1);
p1=mean(p1,1);
c1=mean(c1,1);

p2=mean(p2,1);
v2=mean(v2,1);
c2=mean(c2,1);

G=sqrt(gamma*(v1-v2).^2+beta*(p1-p2).^2+alpha*(c1-c2).^2);
