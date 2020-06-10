function [node_list,tot_num_cells]=runDPonTree(node_list,root_node,params)
%%
tot_num_cells=NaN;
%%
params.tau=compute_tau(root_node);% total sum of branch lengths (local tree)
params.nu=params.lambda*(params.tau+1/params.mu); % normalization of the poisson intensity
setIota_rec(root_node,params.tau,params.mu,true) % insertion probabilities (true: tree rooted at this node)
setBeta_rec(root_node,params.mu,true) % survival probabilities (true: tree rooted at this node)
setAlpha_rec(root_node,params.tau,params.mu);
%%
for i=1:length(node_list)
   node = node_list(i);
   setDistanceToRoot(node);
end
%%
[alphabet_size,extended_alphabet_size]=get_alphabet_size(params.alphabet);
params.alphabet_size=alphabet_size;
params.extended_alphabet_size=extended_alphabet_size;
%%
if strcmp(params.alphabet,'AA')
    [map,inv_map]=loadAAmap();
    params.map=map;
    params.inv_map=inv_map;
else
    [map,inv_map]=loadDNAmap();
    params.map=loadDNAmap();
    params.map=map;
    params.inv_map=inv_map;
end
%%
tot_num_cells = 0;
for i=1:length(node_list)
    node=node_list(i);
    if node.isLeaf
    
    else
        [node_list(i),num_cells]=DP_FFT(node,params);
        
        tot_num_cells = tot_num_cells + num_cells;
    end
end