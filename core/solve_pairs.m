function [pair_out,flag]=solve_pairs(pair_in)

if (size(pair_in.path)==1)
    
    in_block_i_path = pair_in.path(1);
    in_block_i_lk = pair_in.lk{1};
    in_block_i_coord = pair_in.blocks(1,:);
    
    in_block_j_path = [];
    in_block_j_lk = [];
    in_block_j_coord = [];
    
    out_block_i_path = in_block_i_path;
    out_block_i_lk = in_block_i_lk;
    out_block_i_coord = in_block_i_coord;
    
    out_block_j_path = in_block_j_path;
    out_block_j_lk = in_block_j_lk;
    out_block_j_coord = in_block_j_coord;
    
    lk=cell(1,1);
    lk{1}=out_block_i_lk;
    
    flag = true;
    
else
    
    in_block_i_path = pair_in.path(1);
    in_block_i_lk = pair_in.lk{1};
    in_block_i_coord = pair_in.blocks(1,:);
    
    in_block_j_path = pair_in.path(2);
    in_block_j_lk = pair_in.lk{2};
    in_block_j_coord = pair_in.blocks(2,:);
    
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
        lk=cell(1,1);
        lk{1}=out_block_i_lk;
    else
        lk=cell(2,1);
        lk{1}=out_block_i_lk;
        lk{2}=out_block_j_lk;
    end
end

pair_out.path=[out_block_i_path,out_block_j_path];
pair_out.lk=lk;
pair_out.blocks=[out_block_i_coord;
                 out_block_j_coord];
