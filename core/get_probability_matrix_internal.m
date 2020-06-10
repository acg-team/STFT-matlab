function log_thr=get_probability_matrix_internal(node,params)

Pi=params.Pi;

map=params.map;
inv_map=params.inv_map;
%%
numL=size(node.Left.sequence,1);
numR=size(node.Right.sequence,1);
%%
% msaL=char(zeros(numL,map.Count-1));
% msaR=char(zeros(numR,map.Count-1));
%
% for i=1:map.Count-1
%     for j=1:numL
%         msaL(j,i)= inv_map(i);
%     end
%     for j=1:numR
%         msaR(j,i)= inv_map(i);
%     end
% end
%%
N=1000;
iL=uint32(randi(map.Count-1,numL,N));
iR=uint32(randi(map.Count-1,numR,N));

msaL=char(zeros(numL,N));
msaR=char(zeros(numR,N));

for i=1:N
    for j=1:numL
        msaL(j,i)= inv_map(iL(j,i));
    end
    for j=1:numR
        msaR(j,i)= inv_map(iR(j,i));
    end
end
%%
%M=[];
lk=zeros(1,N);
ii=1;
for i=1:N
    
    col_i=msaL(:,i);
    col_j=msaR(:,i);
    
%     r=randi(2);
%     if r==1
%         r=randi(numL);
%         col_i(r)='-';
%     else
%         r=randi(numR);
%         col_j(r)='-';
%     end
    
    %M=[M,[col_i;col_j]];
    
    assign_char_to_leaf(node.Left,col_i,1);
    assign_char_to_leaf(node.Right,col_j,1);
    
    fv0=rec_compute_fv_match(node,map);
    
    lk(ii)=log(node.iota)+log(node.beta)+log(sum(Pi.*fv0));
    ii=ii+1;
    
end
%%
% lk=sort(lk,'desc');
% figure
% hold on
% plot(lk)
% plot([0,length(lk)],[lk(950),lk(950)],'-r')
% hold off

log_thr=lk(950);
%%
%log_thr=min(lk);

%M





%%
% Pi=params.Pi;
% 
% map=params.map;
% inv_map=params.inv_map;
% %%
% numL=size(node.Left.sequence,1);
% numR=size(node.Right.sequence,1);
% 
% msaL=char(zeros(numL,map.Count-1));
% msaR=char(zeros(numR,map.Count-1));
% 
% for i=1:map.Count-1
%     for j=1:numL
%         msaL(j,i)= inv_map(i);
%     end
%     for j=1:numR
%         msaR(j,i)= inv_map(i);
%     end
% end
% %%
% lk=zeros(1,(map.Count-1)*(numL+numR));
% ii=1;
% for i=1:map.Count-1
%     for j=1:2
%         if j==1
%             for k=1:numL
%                 col_i=msaL(:,i);
%                 col_j=msaR(:,i);
%                 
%                 col_i(k)='-';
%                 
%                 %M=[M,[col_i;col_j]];
%                 
%                 assign_char_to_leaf(node.Left,col_i,1);
%                 assign_char_to_leaf(node.Right,col_j,1);
%                 
%                 fv0=rec_compute_fv_match(node,map);
%                 
%                 lk(ii)=log(node.iota)+log(node.beta)+log(sum(Pi.*fv0));
%                 ii=ii+1;
%             end
%             
%         else
%             for k=1:numR
%                 col_i=msaL(:,i);
%                 col_j=msaR(:,i);
%                 
%                 col_j(k)='-';
%                 
%                 %M=[M,[col_i;col_j]];
%                 
%                 assign_char_to_leaf(node.Left,col_i,1);
%                 assign_char_to_leaf(node.Right,col_j,1);
%                 
%                 fv0=rec_compute_fv_match(node,map);
%                 
%                 lk(ii)=log(node.iota)+log(node.beta)+log(sum(Pi.*fv0));
%                 ii=ii+1;
%             end
%         end
%     end
% end
% %%
% log_thr=min(lk)
