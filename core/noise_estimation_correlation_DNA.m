function ck_noise=noise_estimation_correlation_DNA(pi_1,pi_2,l1,l2,n_iterations)

pi_1=padd_seq_DNA(pi_1,l2,'right','double');

ck_noise=v1*0;
for k=1:n_iterations
    
    idx_perm=randperm(size(pi_2,2));
    pi_2_perm=pi_2(:,idx_perm);
    
    pi_2_fl=padd_seq_DNA(pi_2_perm,l1,'left','double');
    
    ck_noise=compute_correlation_fft_DNA(pi_1,pi_2_fl);
    ck_noise=ck_noise+abs(ck);    
end

ck_noise=ck_noise./n_iterations;
