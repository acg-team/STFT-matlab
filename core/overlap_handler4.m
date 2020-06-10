function coords=overlap_handler4(blocks)

%% sort data
blocks=sort_data_v2(blocks,[]);
root=connect_blocks2(blocks);
%% Max's version (linking blocks) 
% leaves=[];
% leaves=traverseTree(root,leaves);
% p=get_block_id(leaves);
% num_path=length(leaves);
%% Manuel's version (linking blocks) 
s=[];
t=[];
w=[];

area=zeros(size(blocks,1),1);
for i=1:size(blocks,1)
   area(i)=(blocks(i,2)-blocks(i,1)+1)*(blocks(i,4)-blocks(i,3)+1);
end

phantom_start_id=0;
phantom_stop_id=size(blocks,1)+1;

for i=1:length(root.children)
    s_id=root.children(i).ID;
    
    s=[s,phantom_start_id];
    t=[t,s_id];
    w=[w,area(s_id)];
    
    for j=1:length(root.children(i).children)
        s=[s,s_id];
        t_id=root.children(i).children(j).ID;
        t=[t,t_id];
        w=[w,area(t_id)];
    end
    
    s=[s,s_id];
    t=[t,phantom_stop_id];
    w=[w,1];
end

s=s+1;
t=t+1;

G = digraph(s,t,-w);

shst_path = shortestpath(G,1,size(blocks,1)+2,'method','mixed');
if length(shst_path)>2
    shst_path=shst_path(2:end-1);
else
    error('ERROR: no block')
end
num_path=1;
p=cell(num_path,1);
p{1}.path=shst_path-1;
%%

p=fill_path_data_v2(p,blocks,num_path);
%%
p=resolve_all_overlaps_v2(p);
%% search the best path
coords=get_best_path_v2(p);