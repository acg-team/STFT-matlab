function thr=compute_distribution_lk_2(seq1,seq2,l1,l2,ck,node,params)

map=params.map;
Pi=params.Pi;
%%
if false
    %[~,idx_max]=max(ck);
end
[~,idx_min]=min(ck);
%%
if false
%     s1_nh_tot=[];
%     s2_nh_tot=[];
%     lk_no_hom=[];
%     ck_idx=idx_max; % statistically no homology
%     k=1;
%     for j=0:1
%         
%         %--------------------------------------
%         % compute lag
%         if l1>=l2
%             lag_k=ck_idx(k)+(j*l1)+1;
%         else
%             if j==0
%                 lag_k=ck_idx(k)+l1+1;
%             else
%                 lag_k=ck_idx(k)-(l2-l1)+1;
%             end
%         end
%         %--------------------------------------
%         
%         if lag_k>0
%             
%             [s1_nh,s2_nh]=shift_sequences_lag(seq1,seq2,lag_k,l1,l2);
%             
%             s1_nh_tot=[s1_nh_tot,s1_nh];
%             s2_nh_tot=[s2_nh_tot,s2_nh];
%             
%             len=size(s1_nh,2);
%             
%             lk=zeros(1,len);
%             for i=1:len
%                 col_i=s1_nh(:,i);
%                 assign_char_to_leaf(node.Left,col_i,1);
%                 
%                 col_j=s2_nh(:,i);
%                 assign_char_to_leaf(node.Right,col_j,1);
%                 
%                 fv0=rec_compute_fv_match(node,map);
%                 
%                 lk(i)=log(node.iota)+log(node.beta)+log(sum(Pi.*fv0));
%             end
%             
%             lk_no_hom=[lk_no_hom,lk];
%             
%         end
%     end
end
%%
s1_h_tot=[];
s2_h_tot=[];
lk_hom=[];
ck_idx=idx_min; % statistically homologous
k=1;
for j=0:1
    
    %--------------------------------------
    % compute lag
    if l1>=l2
        lag_k=ck_idx(k)+(j*l1)+1;
    else
        if j==0
            lag_k=ck_idx(k)+l1+1;
        else
            lag_k=ck_idx(k)-(l2-l1)+1;
        end
    end
    %--------------------------------------
    
    if lag_k>0
        
        [s1_h,s2_h]=shift_sequences_lag(seq1,seq2,lag_k,l1,l2);
        
        s1_h_tot=[s1_h_tot,s1_h];
        s2_h_tot=[s2_h_tot,s2_h];
        
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
if false
%     filename=strcat('./lk_no_hom_',node.name);
%     fid=fopen(filename,'w');
%     for i=1:length(lk_no_hom)
%         fprintf(fid,'%18.16f\n',lk_no_hom(i));
%     end
%     fclose(fid);
end
%%
filename=strcat('./lk_hom_',node.name);
fid=fopen(filename,'w');
for i=1:length(lk_hom)
    fprintf(fid,'%18.16f\n',lk_hom(i));
end
fclose(fid);
%%
s1=s1_h_tot;
s2=s2_h_tot;
fasta=[];
idx=1;
for i=1:size(s1,1)
    fasta(idx).Header = strcat('seq',num2str(idx));
    fasta(idx).Sequence = s1(i,:);
    idx=idx+1;
end
for i=1:size(s2,1)
    fasta(idx).Header = strcat('seq',num2str(idx));
    fasta(idx).Sequence = s2(i,:);
    idx=idx+1;
end

fastawrite(strcat('msaH_',node.name,'.fasta'),fasta);
%%
if false
%     s1=s1_nh_tot;
%     s2=s2_nh_tot;
%     fasta=[];
%     idx=1;
%     for i=1:size(s1,1)
%         fasta(idx).Header = strcat('seq',num2str(idx));
%         fasta(idx).Sequence = s1(i,:);
%         idx=idx+1;
%     end
%     for i=1:size(s2,1)
%         fasta(idx).Header = strcat('seq',num2str(idx));
%         fasta(idx).Sequence = s2(i,:);
%         idx=idx+1;
%     end
%     
%     fastawrite(strcat('msaNH_',node.name,'.fasta'),fasta);
end
%%
lhf=medfilt1(lk_hom,7);
[y,x]=histcounts(lhf,50,'Normalization','pdf');
x=(x(1:end-1)+x(2:end))/2;
f=fit(x.',y.','gauss2');

if f.b1>f.b2
   thr=f.b1-3*f.c1;
else
   thr=f.b2-3*f.c2;
end


