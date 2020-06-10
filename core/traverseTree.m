function path = traverseTree(node,path)

if isempty(node)
else
    
    if isempty(node.children)
        path=[path;node];
    else
        
        for i=1:length(node.children)
            path = traverseTree(node.children(i),path);
        end
        
    end
end

