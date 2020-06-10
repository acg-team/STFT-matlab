function root=expandTree(root,node,coord)

len=size(coord,1);

cx=coord(node.ID,1);
cy=coord(node.ID,3);

for newID=node.ID+1:len
    ncx=coord(newID,1);
    ncy=coord(newID,3);
    
    if ncx>cx && ncy>cy
        insertChild(tree_blocks(newID),node);
    end
end

for i=1:length(node.children)
    root=expandTree(root,node.children(i),coord);
end





