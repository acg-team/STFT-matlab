function thr=compute_threshold_kolmogorov_smirnov(sequence_1,sequence_2,node,params)
map=params.map;
Pi=params.Pi;
alpha=params.alpha;
%%
lenL=size(sequence_1,2);
lenR=size(sequence_2,2);

len=min([lenL,lenR]);
Len=max([lenL,lenR]);
%%

% variante_no_repeat=false;
%
% if variante_no_repeat
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     idx_pair=randperm(Len);
%     idx_pair=idx_pair(1:len);
%
%     if size(sequence_1,2)<size(sequence_2,2)
%         seq_L=sequence_1;
%         seq_R=char(zeros(size(sequence_2,1),size(sequence_1,2)));
%         if size(sequence_2,1)>1
%             for i=1:len
%                 seq_R(:,i)=sequence_2(:,idx_pair(i));
%             end
%         else
%             for i=1:len
%                 seq_R(:,i)=sequence_2(idx_pair(i));
%             end
%         end
%     else
%         seq_L=char(zeros(size(sequence_1,1),size(sequence_2,2)));
%         seq_R=sequence_2;
%         if size(sequence_1,1)>1
%             for i=1:len
%                 seq_L(:,i)=sequence_1(:,idx_pair(i));
%             end
%         else
%             for i=1:len
%                 seq_L(:,i)=sequence_1(idx_pair(i));
%             end
%         end
%     end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%idx_pairL=randi(lenL,len);
%idx_pairR=randi(lenR,len);

idx_pairL=1:len;
idx_pairR=randperm(len);

seq_L=char(zeros(size(sequence_1,1),len));
seq_R=char(zeros(size(sequence_2,1),len));
for i=1:len
    if size(sequence_1,1)>1
        seq_L(:,i)=sequence_1(:,idx_pairL(i));
    else
        seq_L(i)=sequence_1(idx_pairL(i));
    end
    if size(sequence_2,1)>1
        seq_R(:,i)=sequence_2(:,idx_pairR(i));
    else
        seq_R(i)=sequence_2(idx_pairR(i));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%end


% display('perm')
% seq_L
% seq_R
%%
lk_null=zeros(1,len);
for i=1:len
    col_i=seq_L(:,i);
    assign_char_to_leaf(node.Left,col_i,1);
    
    col_j=seq_R(:,i);
    assign_char_to_leaf(node.Right,col_j,1);
    
    fv0=rec_compute_fv_match(node,map);
    
    lk_null(i)=sum(Pi.*fv0);
end


%lk_null

%%
% if false
%     npoints_per_bin=10;
%     N=int32(ceil(len/npoints_per_bin));
%     [f,x]=hist(lk_null,N);
%     fc=cumsum(f);
%
%     fid=fopen('../lk_10','w');
%     for i=1:N
%        fprintf(fid,'%10.8f\n',lk_null(i));
%     end
%     fclose(fid);
%
%     y_alpha=fc(end)*(1-alpha);
%
%     for i=length(fc):-1:1
%         if fc(i)<y_alpha
%             j=i;
%             break;
%         end
%     end
%
%     thr=(x(j)+x(j+1))/2;
% end
%%
filename=strcat('lk_perm_',node.name);
fid=fopen(filename,'w');
for i=1:length(lk_null)
   fprintf(fid,'%18.16f\n',lk_null(i));
end
fclose(fid);
%%
% n_group=2;
% [idx]=kmeans(lk_null',n_group,'Distance','cityblock');
% 
% lk_null_1=lk_null(idx==1);
% lk_null_2=lk_null(idx==2);
% 
% min_1=min(lk_null_1);
% min_2=min(lk_null_2);
% max_1=max(lk_null_1);
% max_2=max(lk_null_2);
% 
% if min_1<min_2
%     thr=(max_1+min_2)/2;
% else
%     thr=(max_2+min_1)/2;
% end

%thr=mean(centroids);
%%
%nbins=500;
%h=histogram(log(lk_null),nbins,'Normalization','cdf');
[y,x]=ecdf(log(lk_null));
%x=(h.BinEdges(1:end-1)+h.BinEdges(2:end))/2;
%y=h.Values;

y20=0.2;

for i=1:length(y)
   if y(i)>y20
       j=i;
       break;
   end
end

thr=x(j);
%%
%%
%%
%%
%%
%%


seq_L2=char(zeros(size(sequence_1,1),len));
seq_R2=char(zeros(size(sequence_2,1),len));
for i=1:len
    if size(sequence_1,1)>1
        seq_L2(:,i)=sequence_1(:,i);
    else
        seq_L2(i)=sequence_1(i);
    end
    if size(sequence_2,1)>1
        seq_R2(:,i)=sequence_2(:,i);
    else
        seq_R2(i)=sequence_2(i);
    end
end


% display('noperm')
% seq_L2
% seq_R2

%%
lk_null_2=zeros(1,len);
for i=1:len
    col_i=seq_L2(:,i);
    assign_char_to_leaf(node.Left,col_i,1);
    
    col_j=seq_R2(:,i);
    assign_char_to_leaf(node.Right,col_j,1);
    
    fv0=rec_compute_fv_match(node,map);
    
    lk_null_2(i)=sum(Pi.*fv0);
end

%lk_null_2

%%
filename=strcat('lk_noperm_',node.name);
fid=fopen(filename,'w');
for i=1:length(lk_null_2)
   fprintf(fid,'%18.16f\n',lk_null_2(i));
end
fclose(fid);



