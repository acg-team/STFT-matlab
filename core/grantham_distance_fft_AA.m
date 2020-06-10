function gd=grantham_distance_fft_AA(v1,v2,p1,p2,c1,c2)

alpha=1.833;
beta=0.1018;
gamma=0.000399;

gv=grantham_fft(v1,v2);
gp=grantham_fft(p1,p2);
gc=grantham_fft(c1,c2);

gd=sqrt(gamma*gv+beta*gp+alpha*gc);