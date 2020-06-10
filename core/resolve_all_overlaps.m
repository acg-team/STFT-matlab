function p = resolve_all_overlaps(p)

loop = 0;

flag_all_resolved=false;
while (~flag_all_resolved)
    
    flag_all_resolved=true;
    
    for k=1:size(p,1)

        p_path=p{k}.path;
        p_lk=p{k}.lk;
        p_blocks=p{k}.blocks;
        
        [f_path,f_lk,f_blocks,flag_all_resolved]=resolve_path(p_path,...
                                                              p_lk,...
                                                              p_blocks,...
                                                              flag_all_resolved);
                                              
        [f_blocks,f_lk,f_path]=sort_data(f_blocks,f_lk,f_path);
        
        p{k}.path=f_path;
        p{k}.lk=f_lk;
        p{k}.blocks=f_blocks;
        
    end
    
    loop = loop + 1;
    loop
    
end