classdef tree_blocks < handle
    
    properties
        ID
    end
    
    properties(SetAccess = private)
        children = tree_blocks.empty;
        Parent = tree_blocks.empty;
    end
    
    methods
        function node = tree_blocks(iD)
            if nargin > 0
                node.ID = iD;
            end
        end
        
        function insertChild(newNode,nodeParent)
            newNode.Parent=nodeParent;
            nodeParent.children=[nodeParent.children,newNode];
        end
        
        function postOrderTraversal(node)
            
            if isempty(node)
            else
                printNode(node);
                for i=1:length(node.children)
                    postOrderTraversal(node.children(i));
                end
            end
            
        end   
        
        function flag=isLeaf(node)
            flag=isempty(node.children);
        end
        
        
        function printNode(node)
            if isempty(node.Parent)
                fprintf('iD %d -> [',node.ID);
                for i=1:length(node.children)
                    fprintf('%d ',node.children(i).ID);
                end
                fprintf(']\n');
            else
                fprintf('iD[%d] %d -> [',node.Parent.ID,node.ID);
                for i=1:length(node.children)
                    fprintf('%d ',node.children(i).ID);
                end
                fprintf(']\n');
            end
        end  
        
    end
    
    methods (Access = private)
        function delete(node)
          
        end
    end
end