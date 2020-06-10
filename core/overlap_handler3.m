function coords=overlap_handler3(blocks,lk_c,d_shift)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%display('checking overlap_handler3....')
%display('checking overlap_handler3 before connect_blocks2')
% T
if size(blocks,1) ~= size(lk_c,1)
    error('blocks e lk_c non hanno la stessa taglia')
end

for i=1:size(blocks,1)
       
    pib=blocks(i,:);

    l1=pib(2)-pib(1)+1;
    l2=pib(4)-pib(3)+1;
    if l1 ~= l2
        error('non e` un quadrato')
    end

    % T
    pilk=lk_c{i};
    lb=pib(2)-pib(1)+1;
    lk=size(pilk,2);
    if lb ~= lk
        error('lk e block non uguali')
    end
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%% remove shift
blocks(:,3)=blocks(:,3)-d_shift;
blocks(:,4)=blocks(:,4)-d_shift;
%% sort data
[blocks,lk_c]=sort_data(blocks,lk_c,[]);
%% build tree of connections
root=connect_blocks2(blocks);
%%
%postOrderTraversal(root)
%%
leaves=[];
leaves=traverseTree(root,leaves);
%%
p=get_block_id(leaves);
%%
num_path=length(leaves);
p=fill_path_data(p,lk_c,blocks,num_path);
%%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%display('checking prima di resolve_all_overlaps....')
for i=1:length(p)
    
    pi=p{i};
    
    % T1
    if size(pi.path,2) ~= size(pi.lk,1)
        error('non ci sono array lk corretti')
    end
    
    % T2
    if size(pi.path,2) ~= size(pi.blocks,1)
        error('non ci sono blocchi corretti')
    end
    
    % T3
    for j=1:size(pi.blocks,1)
        pib=pi.blocks(j,:);
        
        l1=pib(2)-pib(1)+1;
        l2=pib(4)-pib(3)+1;
        if l1 ~= l2
            error('non e` un quadrato')
        end
    end
    
    % T4
    for j=1:size(pi.blocks,1)
        pib=pi.blocks(j,:);
        pilk=pi.lk{j};
        lb=pib(2)-pib(1)+1;
        lk=size(pilk,2);
        if lb ~= lk
            error('non ci sono lk come num colonne')
        end
    end
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%%
%display('entro in resolve_all_overlaps')
p=resolve_all_overlaps(p);
%%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%display('checking dopo resolve_all_overlaps....')
for i=1:length(p)
    
    pi=p{i};
    
    % T1
    if size(pi.path,2) ~= size(pi.lk,1)
        error('non ci sono array lk corretti')
    end
    
    % T2
    if size(pi.path,2) ~= size(pi.blocks,1)
        error('non ci sono blocchi corretti')
    end
    
    % T3
    for j=1:size(pi.blocks,1)
        pib=pi.blocks(j,:);
        
        l1=pib(2)-pib(1)+1;
        l2=pib(4)-pib(3)+1;
        if l1 ~= l2
            error('non e` un quadrato')
        end
    end
    
    % T4
    for j=1:size(pi.blocks,1)
        pib=pi.blocks(j,:);
        pilk=pi.lk{j};
        lb=pib(2)-pib(1)+1;
        lk=size(pilk,2);
        if lb ~= lk
            error('non ci sono lk come num colonne')
        end
    end
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%% search the best path
coords=get_best_path(p);
%% re-add the shift
coords(:,3)=coords(:,3)+d_shift;
coords(:,4)=coords(:,4)+d_shift;
