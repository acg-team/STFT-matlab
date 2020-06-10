function [f_path,f_lk,f_blocks,flag_all_resolved]=resolve_path(p_path,p_lk,p_blocks,flag_all_resolved)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%display('in resolve_path checking data...')

for i=1:size(p_blocks,1)
       
    pib=p_blocks(i,:);

    l1=pib(2)-pib(1)+1;
    l2=pib(4)-pib(3)+1;
    if l1 ~= l2
        error('resolve_path prima: non e` un quadrato')
    end

    % T
    pilk=p_lk{i};
    lb=pib(2)-pib(1)+1;
    lk=size(pilk,2);
    if lb ~= lk
        
%         pilk
%         pib
%         
        error('resolve_path prima: lk e block non uguali')
    end
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%%
%display('entro in  split_block_pairs...')
%pairs = split_block_pairs(p_path,p_lk,p_blocks);
pairs = split_block_pairs_v2(p_path,p_lk,p_blocks);
%%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%display('uscito da split_block_pairs...')
% if size(pairs,2)>size(pairs,1)
%     error('resolve_path dopo split_block_pairs: size p non ok')
% end
% 
% for i=1:length(pairs)
%     
%     p_i=pairs{i};
%     
%     if length(p_i.path) == 1
%         
%         if length(p_i.path) >1
%             error('ERROR in split_block_pairs dopo pairs, path troppo lungo')
%         end
%         
%         pib=p_i.blocks;
%         
%         if (pib(2)-pib(1)) ~= (pib(4)-pib(3))
%             error('ERROR in split_block_pairs dopo pairs, non e un quadrato')
%         end
%         
%         lb=pib(2)-pib(1)+1;
%         
%         pilk=p_i.lk{1};
%         lk=size(pilk,2);
%         
%         if lb ~= lk
%             error('ERROR in split_block_pairs dopo pairs: lk e block non uguali')
%         end
%         
%     elseif length(p_i.path) == 2
%         
%         if size(p_i.path,2) ~= 2
%             error('ERROR in split_block_pairs dopo pairs, path non 2')
%         end
%         
%         pib=p_i.blocks;
%         
%         if size(pib,1) ~= 2 || size(pib,2) ~= 4
%             error('ERROR in split_block_pairs dopo pairs, path non 2 o 4')
%         end
%         
%         if (pib(1,2)-pib(1,1)) ~= (pib(1,4)-pib(1,3))
%             error('ERROR in split_block_pairs dopo pairs, non e un quadrato')
%         end
%         if (pib(2,2)-pib(2,1)) ~= (pib(2,4)-pib(2,3))
%             error('ERROR in split_block_pairs dopo pairs, non e un quadrato')
%         end
%         
%         lb=pib(1,2)-pib(1,1)+1;
%         
%         pilk=p_i.lk{1};
%         lk=size(pilk,2);
%         
%         if lb ~= lk
%             error('ERROR in split_block_pairs dopo pairs: lk e block non uguali')
%         end
%         
%         lb=pib(2,2)-pib(2,1)+1;
%         
%         pilk=p_i.lk{2};
%         lk=size(pilk,2);
%         
%         if lb ~= lk
%             error('ERROR in split_block_pairs dopo pairs: lk e block non uguali')
%         end
%         
%     else
%         error('ERROR in split_block_pairs dopo pairs piu di 2 blocchi')
%     end
% end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%%
[f,flag_all_resolved]=resolve_block_pairs(pairs,flag_all_resolved);
%%
%display('compose solution')
%[f_path,f_lk,f_blocks] = connect_sub_solutions(f);
[f_path,f_lk,f_blocks] = connect_sub_solutions_v2(f);



