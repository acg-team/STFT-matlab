function ck_noise=noise_estimation_grantham_AA(v1,p1,v2,p2,c1,c2,n_iterations)

l1=size(v1,2);
l2=size(v2,2);
%l=size(v2,2);

%ck_noise=v1*0;

%ck_noise_v=zeros(1,n_iterations);

%----------------------------------------------------------------------
% padding
if l1==l2
    
elseif l1<l2
    pad_length=l2-l1;
    v1=padd_seq_with_value_AA(v1,pad_length,'right',mean(v1));
    p1=padd_seq_with_value_AA(p1,pad_length,'right',mean(p1));
    c1=padd_seq_with_value_AA(c1,pad_length,'right',mean(c1));
elseif l1>l2
    pad_length=l1-l2;
    v2=padd_seq_with_value_AA(v2,pad_length,'right',mean(v2));
    p2=padd_seq_with_value_AA(p2,pad_length,'right',mean(p2));
    c2=padd_seq_with_value_AA(c2,pad_length,'right',mean(c2));
end
%----------------------------------------------------------------------


l2pad=size(v2,2);

ck_noise=0;
for k=1:n_iterations
    idx_perm=randperm(l2pad);
    
    v2_perm=v2(idx_perm);
    p2_perm=p2(idx_perm);
    c2_perm=c2(idx_perm);
 
    ck=grantham_distance_fft(v1,v2_perm,p1,p2_perm,c1,c2_perm);
    
    %ck_noise=ck_noise+abs(ck);
    ck_noise=ck_noise+min(abs(ck));
    %ck_noise_v(k)=ck_noise;
end

ck_noise=ck_noise./n_iterations;

%plot(ck_noise_v./[1:length(ck_noise_v)],':o')