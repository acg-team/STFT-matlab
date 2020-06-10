function ck=compute_ck_grantham(v1,v2,p1,p2,c1,c2,params,noise_thr)


if strcmp(params.alphabet,'AA')
    ck=grantham_distance_fft(v1,v2,p1,p2,c1,c2);
else
    %TODO grantham for nucleotides
end
