function ck_noise=noise_estimation_correlation_AA(v1,p1,v2,p2,c1,c2,l1,l2,n_iterations)

v1=padd_seq_AA(v1,l2,'right','double',0);
p1=padd_seq_AA(p1,l2,'right','double',0);
c1=padd_seq_AA(c1,l2,'right','double',0);

ck_noise=v1*0;
for k=1:n_iterations
    idx_perm=randperm(l2);
    v2_perm=v2(idx_perm);
    p2_perm=p2(idx_perm);
    c2_perm=c2(idx_perm);
    
    v2_fl=padd_seq_AA(v2_perm,l1,'left','double',0);
    p2_fl=padd_seq_AA(p2_perm,l1,'left','double',0);
    c2_fl=padd_seq_AA(c2_perm,l1,'left','double',0);

    ck=compute_correlation_fft_AA(v1,p1,v2_fl,p2_fl,c1,c2_fl);

    ck_noise=ck_noise+abs(ck);
end

ck_noise=ck_noise./n_iterations;
