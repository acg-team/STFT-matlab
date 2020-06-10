function gd=grantham_distance_fft_DNA(vA1,vA2,vC1,vC2,vG1,vG2,vT1,vT2,vE1,vE2)

gAv=grantham_fft(vA1,vA2);
gCv=grantham_fft(vC1,vC2);
gGv=grantham_fft(vG1,vG2);
gTv=grantham_fft(vT1,vT2);
gEv=grantham_fft(vE1,vE2);

gd=sqrt(gAv+gCv+gGv+gTv+gEv);