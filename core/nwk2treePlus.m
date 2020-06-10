function [D,root] =  nwk2treePlus(nwktreefile, Q)
T=phytreeread(nwktreefile);
%%

[MATRIX, ID, DIST] = getmatrix(T);
%%
nNodes=size(ID,1);
D=[];
for i=1:nNodes
    d=dlnodeTree(i);
    setNodename(d,ID{i});
    d.br_l = DIST(i);
    setPr(d,Q);
    set_sequence_name(d);
    D=[D;d];
end

for i=1:nNodes
    for j=1:nNodes
        if MATRIX(i,j) ~= 0
            id_parent=i;
            id_child=j;
            insertChild(D(id_child),D(id_parent))
        end
    end
end

l = get(T,'LeafNames');
for i = 1:length(l)
    for j = 1:length(l)
        if convertCharsToStrings(D(i).name) == convertCharsToStrings(l{j})
            setIsLeaf(D(i),true)
        end
    end
end

for i = 1:nNodes
    if isempty(D(i).is_leaf)
        setIsLeaf(D(i),false)
    end
end

for i = 1:nNodes
    if isempty(D(i).Parent)
       root=D(i); 
       break;
    end
end

end