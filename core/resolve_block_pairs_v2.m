function [f,flag_all_resolved]=resolve_block_pairs_v2(pairs,flag_all_resolved)


N=length(pairs);

if N>1
    
    f=cell(size(pairs,1),1);
    
    for i=1:length(pairs)-1
        
        [pair_out,flag]=solve_pairs_v3(pairs{i});
        
        f=update_this_pair(f,i,N,pair_out);
        
        pairs{i+1}=update_next_pair_v2(pair_out,pairs{i+1});
    
        flag_all_resolved=flag_all_resolved & flag;
        
    end
    
    [pair_out,flag]=solve_pairs_v3(pairs{end});
    
    f=update_this_pair(f,N,N,pair_out);
    
    flag_all_resolved=flag_all_resolved & flag;
    
else
    
    f=cell(1,1);
    
    [pair_out,flag]=solve_pairs_v3(pairs{1});
    
    f=update_this_pair(f,1,N,pair_out);

    flag_all_resolved=flag_all_resolved & flag;
    
end

