function ck_noise=noise_estimation_DNA(A1,C1,G1,T1,E1,A2,C2,G2,T2,E2,n_iterations,params)

%[A1,C1,G1,T1,E1,A2,C2,G2,T2,E2]=pad_DNA(A1,C1,G1,T1,E1,A2,C2,G2,T2,E2,params);

%all_ck=[];

l1_after_pad=size(A2,2);
l2_after_pad=size(A1,2);

if l1_after_pad ~= l2_after_pad
   error('ERROR in noise_estimation_DNA') 
else
    length_after_pad=l1_after_pad;
end

ck_noise=0;
for k=1:n_iterations
    
    idx_perm=randperm(length_after_pad);
    
    A2_perm=A2(idx_perm);
    C2_perm=C2(idx_perm);
    G2_perm=G2(idx_perm);
    T2_perm=T2(idx_perm);
    E2_perm=E2(idx_perm);
    if strcmp(params.homologous_approach,'correlation')
        ck=compute_correlation_fft_DNA(A1,A2_perm,...
                                       C1,C2_perm,...
                                       G1,G2_perm,...
                                       T1,T2_perm,...
                                       E1,E2_perm);
    elseif strcmp(params.homologous_approach,'grantham')         
        ck=grantham_distance_fft_DNA(A1,A2_perm,...
                                     C1,C2_perm,...
                                     G1,G2_perm,...
                                     T1,T2_perm,...
                                     E1,E2_perm);
    end
    
    if strcmp(params.homologous_approach,'correlation')
        ck_noise=ck_noise+max(abs(ck));
    elseif strcmp(params.homologous_approach,'grantham')        
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
% filename=strcat('../all_ck_',nodename);
% fid=fopen(filename,'w');
% fprintf(fid,'%18.16f\n',ck_noise);
% for i=1:length(all_ck)
%    fprintf(fid,'%18.16f\n',all_ck(i));
% end
% fprintf(fid,'%18.16f\n',ck_noise);
% fclose(fid);


