function [ck_idx,num_k]=filter_ck(ck,noise_thr,params)

if strcmp(params.homologous_approach,'correlation')
    [ck_sorted,ck_idx]=sort(ck,'desc');
    bool_ck=abs(ck_sorted)<noise_thr;
elseif strcmp(params.homologous_approach,'grantham')
    [ck_sorted,ck_idx]=sort(ck,'asc');
    bool_ck=abs(ck_sorted)>noise_thr;
end

ck_idx(bool_ck)=[];
num_k=length(ck_idx);
