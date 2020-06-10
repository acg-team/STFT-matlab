function [D,root] = nwk2tree(nwktreefile,varargin)

T=phytreeread(nwktreefile);

node_names=get(T,'NodeNames');
pointers=get(T,'Pointers');
numLeaves=get(T,'NumLeaves');
numNodes=get(T,'NumNodes');
distances=get(T,'Distances');

D=[];
for i=1:numNodes
    d=dlnodeTree(i);
    setNodename(d,node_names{i});
    d.br_l = distances(i);
    if nargin==2
        setPr(d,varargin{1});
    end
    D=[D;d];
end

for i=1:size(pointers,1)
   D(i+numLeaves).Left=D(pointers(i,1));
   D(i+numLeaves).Right=D(pointers(i,2));
   D(i+numLeaves).Left.Parent=D(i+numLeaves);
   D(i+numLeaves).Right.Parent=D(i+numLeaves);
   
end

for i=1:numLeaves
    D(i).sequence_name{1}=node_names{i};
    setIsLeaf(D(i),true);
end
for i=numLeaves+1:numNodes
    set_sequence_name(D(i))
    setIsLeaf(D(i),false);
end

root=D(end);
