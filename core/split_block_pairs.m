function p = split_block_pairs(p_path,p_lk,p_blocks)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%display('dentro split_block_pairs checking data...')
if size(p_lk,2)>size(p_lk,1)
    p_lk = p_lk';
    warnings('WARNING: split_block_pairs, traspongo')
end

if size(p_path,1)>size(p_path,2)
    error('ERROR: split_block_pairs, size p_path')
end

if size(p_blocks,2) ~= 4
    error('ERROR: split_block_pairs, p_blocks')
end

if size(p_path,2) ~= size(p_lk,1)
    error('ERROR: split_block_pairs, size p_path ~= p_lk')
end

if size(p_path,2) ~= size(p_blocks,1)
    error('ERROR: split_block_pairs, size p_path ~= p_lk')
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%%
if length(p_path)>1
    
    p=cell(length(p_path)-1,1);

    for i=1:length(p_path)-1
        p{i}.path=[p_path(i),p_path(i+1)];
        
        lk=cell(2,1);
        lk{1}=p_lk{i};
        lk{2}=p_lk{i+1};
        p{i}.lk=lk;
        
        p{i}.blocks=[p_blocks(i,:);p_blocks(i+1,:)];
    end
else
    if size(p_path,2)>1
        error('ERROR in resolve_path')
    end
    if length(p_lk)>1
        error('ERROR in resolve_path')
    end
    if size(p_blocks,1)>1
        error('ERROR in resolve_path')
    end
    
    p=cell(1,1);
    
    p{1}.path=p_path;
    p{1}.lk=p_lk;
    p{1}.blocks=p_blocks;
end
%%
if size(p,2)>size(p,1)
    p=p';
    warnings('WARNING resolve_path traspongo p')
end




