function p = resolve_all_overlaps_v2(p)

loop = 0;

flag_all_resolved=false;
while (~flag_all_resolved)
    
    flag_all_resolved=true;
    
    for k=1:size(p,1)

        p_path=p{k}.path;

        p_blocks=p{k}.blocks;
        
        [f_path,f_blocks,flag_all_resolved]=resolve_path_v2(p_path,...
                                                              p_blocks,...
                                                              flag_all_resolved);
                                              
        [f_blocks,f_path]=sort_data_v2(f_blocks,f_path);
        
        p{k}.path=f_path;

        p{k}.blocks=f_blocks;
        
    end
    
    loop = loop + 1;
    loop
    
end