function p = split_block_pairs_v2(p_path,p_lk,p_blocks)

if length(p_path)>1
    
    p=cell(length(p_path)-1,1);

    for i=1:length(p_path)-1
        
        p{i}=cell(2,1);
        
        p{i}{1}.path = p_path(i);
        p{i}{1}.lk = p_lk{i};
        p{i}{1}.blocks=p_blocks(i,:);
          
        p{i}{2}.path = p_path(i+1);
        p{i}{2}.lk = p_lk{i+1};
        p{i}{2}.blocks=p_blocks(i+1,:);
        
    end
    
else
    
    p=cell(1,1);
    
    p{1}=cell(1,1);
    
    p{1}{1}.path = p_path(1);
    p{1}{1}.lk = p_lk{1};
    p{1}{1}.blocks=p_blocks(1,:);
    
end





