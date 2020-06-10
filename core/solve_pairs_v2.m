function [pair_out,flag]=solve_pairs_v2(pair_in)

if (length(pair_in) == 1)
    
    pair_out = cell(1,1); 
    pair_out{1}.path = pair_in{1}.path;
    pair_out{1}.lk = pair_in{1}.lk;
    pair_out{1}.blocks = pair_in{1}.blocks;
    
    flag = true;
    
else
    
    in_block_i_path = pair_in{1}.path;
    in_block_i_lk = pair_in{1}.lk;
    in_block_i_coord = pair_in{1}.blocks;
    
    in_block_j_path = pair_in{2}.path;
    in_block_j_lk = pair_in{2}.lk;
    in_block_j_coord = pair_in{2}.blocks;
    
    [out_block_i_path,...
        out_block_i_lk,...
        out_block_i_coord,...
        out_block_j_path,...
        out_block_j_lk,...
        out_block_j_coord,...
        flag]=resolve_2_blocks(...
        in_block_i_path,...
        in_block_i_lk,...
        in_block_i_coord,...
        in_block_j_path,...
        in_block_j_lk,...
        in_block_j_coord);
    
    if isempty(out_block_j_lk)
        
        pair_out = cell(1,1);
        pair_out{1}.path = out_block_i_path;
        pair_out{1}.lk = out_block_i_lk;
        pair_out{1}.blocks = out_block_i_coord;
        
    else
        
        pair_out = cell(2,1);
        
        pair_out{1}.path = out_block_i_path;
        pair_out{1}.lk = out_block_i_lk;
        pair_out{1}.blocks = out_block_i_coord;

        pair_out{2}.path = out_block_j_path;
        pair_out{2}.lk = out_block_j_lk;
        pair_out{2}.blocks = out_block_j_coord;
    end

end



