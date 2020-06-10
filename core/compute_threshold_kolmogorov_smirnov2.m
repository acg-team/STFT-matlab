function thr=compute_threshold_kolmogorov_smirnov2(sequence_1,sequence_2,node,params)
map=params.map;
Pi=params.Pi;
%%
len1=size(sequence_1,2);
len2=size(sequence_2,2);
len=len1*len2;
%%
idx_pairL=zeros(1,len);
idx_pairR=zeros(1,len);
k=1;
for i=1:len1
    for j=1:len2
        idx_pairL(k)=i;
        idx_pairR(k)=j;
        k=k+1;
    end
end
%%
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
%%
lk_null=zeros(1,len);
for i=1:len
    col_i=seq_L(:,i);
    assign_char_to_leaf(node.Left,col_i,1);
    
    col_j=seq_R(:,i);
    assign_char_to_leaf(node.Right,col_j,1);
    
    fv0=rec_compute_fv_match(node,map);
    
    lk=node.iota*node.beta*sum(Pi.*fv0);
    
    lk_null(i)=lk;
end
%%
filename=strcat('../lk_perm_',node.name);
fid=fopen(filename,'w');
for i=1:length(lk_null)
   fprintf(fid,'%18.16f\n',lk_null(i));
end
fclose(fid);
%%
[y,x]=ecdf(log(lk_null));
y95=0.95;
for i=1:length(y)
   if y(i)>y95
       j=i;
       break;
   end
end

thr=x(j);

