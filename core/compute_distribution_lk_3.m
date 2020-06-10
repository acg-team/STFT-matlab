function [thr,m,M]=compute_distribution_lk_3(seq1,seq2,l1,l2,ck,node,params)

%map=params.map;
%Pi=params.Pi;
%%
%[~,idx_max]=max(ck);
[~,idx_min]=min(ck);
%%
G=[];
ik=1;
ck_hom=idx_min;
for j=0:1
    if l1>=l2
        lag_k=ck_hom+1+(j*l1);
    else
        if j==0
            lag_k=ck_hom+l1+1;
        else
            lag_k=ck_hom-(l2-l1)+1;
        end
    end
    if lag_k>0
        
        [s1_h,s2_h]=shift_sequences_lag(seq1,seq2,lag_k,l1,l2);
        
        alpha=1.833;
        beta=0.1018;
        gamma=0.000399;
        
        v1=get_volume(s1_h,params.map);
        v2=get_volume(s2_h,params.map);
        p1=get_polarity(s1_h,params.map);
        p2=get_polarity(s2_h,params.map);
        c1=get_composition(s1_h,params.map);
        c2=get_composition(s2_h,params.map);
        
        v1=mean(v1,1);
        v2=mean(v2,1);
        p1=mean(p1,1);
        p2=mean(p2,1);
        c1=mean(c1,1);
        c2=mean(c2,1);
        
        G{ik}=sqrt(gamma*(v1-v2).^2+beta*(p1-p2).^2+alpha*(c1-c2).^2);
        ik=ik+1;
    end
end
%%
m=inf;
M=-inf;
filename=strcat('../GD_',node.name);
fid=fopen(filename,'w');
for i=1:length(G)
    for j=1:length(G{i})
        fprintf(fid,'%18.16f ',G{i}(j));
        
        if G{i}(j)>M
            M=G{i}(j);
        end
        if G{i}(j)<m
            m=G{i}(j);
        end
    end
    fprintf(fid,'\n');
end
fclose(fid);
%%
thr=0.2;

