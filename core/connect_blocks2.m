function root=connect_blocks2(coord)

len=size(coord,1);

root = tree_blocks(0);

for i=1:len
    insertChild(tree_blocks(i),root);
end

for i=1:length(root.children)
    root=expandTree(root,root.children(i),coord);
end

