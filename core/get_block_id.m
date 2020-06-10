function p=get_block_id(leaves)

num_path=length(leaves);
p=cell(num_path,1);
for i=1:length(leaves)
    
    leaf=leaves(i);
    pIDs=leaf.ID;
    
    leaf=leaf.Parent;
    while ~isempty(leaf.Parent)
        pIDs=[leaf.ID,pIDs];
        leaf=leaf.Parent;
    end
    
    p{i}.path=pIDs;
end
