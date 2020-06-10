classdef dlnodeTree < handle
    
    properties
        iD
        iota
        beta
        Pr
        br_l
        sequence
        sequence_name
%         fv_s
%         fv
        is_leaf
        name
        ch
        dist2root
        alpha
    end
    
    properties(SetAccess = public)
        Left = dlnodeTree.empty;
        Right = dlnodeTree.empty;
        Parent = dlnodeTree.empty;
    end
    
    methods
        function node = dlnodeTree(iD)
            if nargin > 0
                node.iD = iD;
            end
        end
        
        function set_sequence_name(node)
            
            if not(isempty(node.Left)) && not(isempty(node.Right))
                
                N=size(node.Left.sequence_name,1)+size(node.Right.sequence_name,1);
                C=cell(N,1);
                idx=1;
                for i=1:size(node.Left.sequence_name,1)
                    C{idx}=node.Left.sequence_name{i};
                    idx=idx+1;
                end
                for i=1:size(node.Right.sequence_name,1)
                    C{idx}=node.Right.sequence_name{i};
                    idx=idx+1;
                end
                node.sequence_name=C;
            end
            
        end
        
        function swapNodes(node)
            nodeTmp=node.Left;
            node.Left=node.Right;
            node.Right=nodeTmp;
        end
        
        function insertChild(newNode,nodeParent)
            if isempty(nodeParent.Left)
                nodeParent.Left=newNode;
                newNode.Parent=nodeParent;    
            elseif isempty(nodeParent.Right)
                nodeParent.Right=newNode;
                newNode.Parent=nodeParent;
            else
                disp('ERROR: two children occupied')
            end
        end
        
        function postOrderTraversal(node)
            if isempty(node)
            else
                postOrderTraversal(node.Left);
                postOrderTraversal(node.Right);
                printNode(node);
            end
        end
        
        function preOrderTraversal(node)
            if isempty(node)
            else
                printNode(node);
                postOrderTraversal(node.Left);
                postOrderTraversal(node.Right);
            end
        end
        
        function setDistanceToRoot(node)
           
            dist=0;
            tmp_node=node;
            while ~isempty(tmp_node)
                dist = dist+tmp_node.br_l;
                tmp_node = tmp_node.Parent;
            end
            
            setDist(node,dist);
            
        end
        
        function inOrderTraversal(node)
            if isempty(node)
            else
                postOrderTraversal(node.Left);
                printNode(node);
                postOrderTraversal(node.Right);
            end
        end
        
        function tau=compute_tau(node)
            if node.is_leaf
                tau=0.0;
            else
                tauL=compute_tau(node.Left);
                tauR=compute_tau(node.Right);
                tau=tauL + tauR + node.Left.br_l + node.Right.br_l;
            end
        end
        
        function idx=assign_char_to_leaf(node,msa_col,idx) 
            if node.is_leaf
                node.ch=msa_col(idx);
                idx=idx+1;
            else
                idx=assign_char_to_leaf(node.Left,msa_col,idx);
                idx=assign_char_to_leaf(node.Right,msa_col,idx);
            end
        end
        
        function setDist(node,d)
            node.dist2root=d;
        end
        
        function setIsLeaf(node,flag)
            node.is_leaf=flag;
        end
        
        function flag=isLeaf(node)
            flag=node.is_leaf;
        end
        
        function setNodeSequence(node,sequence)
            node.sequence_name{1}=sequence.Header;
            node.sequence=sequence.Sequence;
        end
        
        function setNodename(node,name)
            node.name=name;
        end
        
        function setAlpha(node,alpha)
            node.alpha=alpha;
        end
        
        function setIota(node,iota)
            node.iota=iota;
        end
        
        function setBeta(node,beta)
            node.beta=beta;
        end        
        
        function setBeta_rec(node,mu,flag)
            
            if flag
                flag=false;
                betaVal=1;
            else
                betaVal=(1-exp(-mu*node.br_l))/(mu*node.br_l);
            end
            
            setBeta(node,betaVal);
            
            if node.is_leaf
                
            else
                setBeta_rec(node.Left,mu,flag)
                setBeta_rec(node.Right,mu,flag)
            end
        end
        
        function setAlpha_rec(node,tau,mu)
            
            alpha_val=(1/mu)/(tau+1/mu);
            
            setAlpha(node,alpha_val);
            
            if node.is_leaf
                
            else
                setAlpha_rec(node.Left,tau,mu)
                setAlpha_rec(node.Right,tau,mu)
            end
        end
        
        function setIota_rec(node,tau,mu,flag)
            
            if flag
                flag=false;
                iotaVal=(1/mu)/(tau+1/mu);
            else
                iotaVal=node.br_l/(tau+1/mu);
            end
            
            alpha_val=(1/mu)/(tau+1/mu);
            
            setAlpha(node,alpha_val);
            setIota(node,iotaVal);
            
            if node.is_leaf
                
            else
                setIota_rec(node.Left,tau,mu,flag)
                setIota_rec(node.Right,tau,mu,flag)
            end
        end
        
        function setPr(node,Q)
            node.Pr=expm(node.br_l*Q);
        end
        
        function setBrl(node,br_l)
            node.br_l=br_l;
        end        
  
        function printIota(node)
            disp(node.iota);
        end
        
        function printBeta(node)
            disp(node.beta);
        end        
        
        function printPr(node)
            disp(node.Pr);
        end
        
        function printName(node)
            disp(node.name);
        end
        
        function printBrl(node)
            disp(node.br_l);
        end        

        function printNode(node)
%             fprintf('iD: %d\n',node.iD);
            fprintf('name: %s\n',node.name);
%             %fprintf('sequence_name: %s\n',node.sequence_name);
%             fprintf('sequence: %s\n',node.sequence);
%             fprintf('char: %s\n',node.ch);
%             fprintf('iota: %f\n',node.iota);
%             fprintf('beta: %f\n',node.beta);
%             fprintf('br_l: %f\n',node.br_l);
%             if node.is_leaf==0
%                 fprintf('%s - %s\n',node.Left.name,node.Right.name)
%             end
%             fprintf('Pr: %d x %d\n',size(node.Pr,1),size(node.Pr,2));
%             %disp(node.Pr);
%             fprintf('-------------------\n');
        end  
        
        
        function print_rec(node)
            if node.is_leaf
                fprintf('node: %s\n',node.name);
                fprintf('iota: %f\n',node.iota);
                fprintf('beta: %f\n',node.beta);
            else
                print_rec(node.Left)
                print_rec(node.Right)
                fprintf('node: %s\n',node.name);
                fprintf('iota: %f\n',node.iota);
                fprintf('beta: %f\n',node.beta);
            end
        end
        
        
        %         function insertBefore(newNode, nodeAfter)
        %             % Insert newNode before nodeAfter.
        %             removeNode(newNode);
        %             newNode.Next = nodeAfter;
        %             newNode.Prev = nodeAfter.Prev;
        %             if ~isempty(nodeAfter.Prev)
        %                 nodeAfter.Prev.Next = newNode;
        %             end
        %             nodeAfter.Prev = newNode;
        %         end
        
        %         function removeNode(node)
        %             % Remove a node from a linked list.
        %             if ~isscalar(node)
        %                 error('Input must be scalar')
        %             end
        %             prevNode = node.Prev;
        %             nextNode = node.Next;
        %             if ~isempty(prevNode)
        %                 prevNode.Next = nextNode;
        %             end
        %             if ~isempty(nextNode)
        %                 nextNode.Prev = prevNode;
        %             end
        %             node.Next = dlnode.empty;
        %             node.Prev = dlnode.empty;
        %         end
        
        %         function clearList(node)
        %             % Clear the list before
        %             % clearing list variable
        %             prev = node.Prev;
        %             next = node.Next;
        %
        %             removeNode(node)
        %
        %             while ~isempty(next)
        %                 node = next;
        %                 next = node.Next;
        %                 removeNode(node);
        %             end
        %
        %             while ~isempty(prev)
        %                 node = prev;
        %                 prev = node.Prev;
        %                 removeNode(node)
        %             end
        %
        %         end
    end
    
    methods (Access = private)
        function delete(node)
            %clearList(node)
        end
    end
end