function ck_noise=noise_estimation_AA(v1,p1,v2,p2,c1,c2,n_iterations,params)

%[v1,p1,c1,v2,p2,c2]=pad_AA(v1,p1,c1,v2,p2,c2,params);

%all_ck=[];
l1_after_pad=size(v1,2);
l2_after_pad=size(v2,2);

if l1_after_pad ~= l2_after_pad
   error('ERROR in noise_estimation_AA') 
else
    length_after_pad=l1_after_pad;
end

ck_noise=0;
for k=1:n_iterations
    
    idx_perm=randperm(length_after_pad);
    
    v2_perm=v2(idx_perm);
    p2_perm=p2(idx_perm);
    c2_perm=c2(idx_perm);
    
    if strcmp(params.homologous_approach,'correlation')
        ck=compute_correlation_fft_AA(v1,v2_perm,p1,p2_perm,c1,c2_perm);
        ck_noise=ck_noise+max(abs(ck));
    elseif strcmp(params.homologous_approach,'grantham')        
        ck=grantham_distance_fft_AA(v1,v2_perm,p1,p2_perm,c1,c2_perm);   
        ck_noise=ck_noise+min(abs(ck));
    end

    %all_ck=[all_ck,ck];
    
end

ck_noise=ck_noise./n_iterations;
%%
%[muhat,sigmahat] = normfit(all_ck);
%standard_z_score_0_95 = 1.644854;
%ck_noise = standard_z_score_0_95*sigmahat+muhat
%standard_z_score_0_05 = -1.644854;
%ck_noise = standard_z_score_0_05*sigmahat+muhat
%%
% filename=strcat('../ck_noise',nodename);
% fid=fopen(filename,'w');
% fprintf(fid,'%18.16f\n',ck_noise);
% for i=1:length(all_ck)
%    fprintf(fid,'%18.16f\n',all_ck(i));
% end
% fprintf(fid,'%18.16f\n',ck_noise);
% fclose(fid);

