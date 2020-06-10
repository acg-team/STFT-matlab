function [f_path,f_blocks,flag_all_resolved]=resolve_path_v2(p_path,p_blocks,flag_all_resolved)

pairs = split_block_pairs_v3(p_path,p_blocks);
[f,flag_all_resolved]=resolve_block_pairs_v2(pairs,flag_all_resolved);
[f_path,f_blocks] = connect_sub_solutions_v3(f);



