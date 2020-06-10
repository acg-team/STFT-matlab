function thr=compute_distribution_lk(seq1,seq2,l1,l2,ck,node,params)

map=params.map;
Pi=params.Pi;
%%
[~,idx_max]=max(ck);
[~,idx_min]=min(ck);
%%
% lk_null=[];
% ck_no_hom=idx_max;
% for j=0:1
%     if l1>=l2
%         lag_k=ck_no_hom+1+(j*l1);
%     else
%         if j==0
%             lag_k=ck_no_hom+l1+1;
%         else
%             lag_k=ck_no_hom-(l2-l1)+1;
%         end
%     end
%     if lag_k>0
%         
%         [s1_nh,s2_nh]=shift_sequences_lag(seq1,seq2,lag_k,l1,l2);
%         
%         len=size(s1_nh,2);
%         
%         lk=zeros(1,len);
%         for i=1:len
%             col_i=s1_nh(:,i);
%             assign_char_to_leaf(node.Left,col_i,1);
%             
%             col_j=s2_nh(:,i);
%             assign_char_to_leaf(node.Right,col_j,1);
%             
%             fv0=rec_compute_fv_match(node,map);
%             
%             lk(i)=log(node.iota)+log(node.beta)+log(sum(Pi.*fv0));
%         end
%         
%         lk_null=[lk_null,lk];
%         
%     end
% end
%%
lk_hom=[];
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
        
        len=size(s1_h,2);
        
        lk=zeros(1,len);
        for i=1:len
            col_i=s1_h(:,i);
            assign_char_to_leaf(node.Left,col_i,1);
            
            col_j=s2_h(:,i);
            assign_char_to_leaf(node.Right,col_j,1);
            
            fv0=rec_compute_fv_match(node,map);
            
            lk(i)=log(node.iota)+log(node.beta)+log(sum(Pi.*fv0));
        end
        
        lk_hom=[lk_hom,lk];
    end
end
%%
% filename=strcat('lk_null_',node.name);
% fid=fopen(filename,'w');
% for i=1:length(lk_null)
%    fprintf(fid,'%18.16f\n',lk_null(i));
% end
% fclose(fid);
% 
% filename=strcat('lk_hom_',node.name);
% fid=fopen(filename,'w');
% for i=1:length(lk_hom)
%    fprintf(fid,'%18.16f\n',lk_hom);
% end
% fclose(fid);
%%

lk_null=lk_hom';

n_group=2;
[idx]=kmeans(lk_null,n_group,'Distance','cityblock');

lk_null_1=lk_null(idx==1);
lk_null_2=lk_null(idx==2);

min_1=min(lk_null_1);
min_2=min(lk_null_2);
max_1=max(lk_null_1);
max_2=max(lk_null_2);

if min_1<min_2
    %thr=(max_1+min_2)/2;
    thr=max_1;
else
    %thr=(max_2+min_1)/2;
    thr=max_2;
end

%thr=mean(centroids);

