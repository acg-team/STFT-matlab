function [lk,fv]=rec_compute_lk_empty_col(node,Pi,map)

if node.is_leaf
        
    extended_alphabet_size=size(node.Pr,1);
    fv=zeros(extended_alphabet_size,1);
    fv(end)=1;
    
    lk=node.iota*(1+(node.beta*(-1+sum(Pi.*fv))));
else
    [lk_L,fv_L]=rec_compute_lk_empty_col(node.Left,Pi,map);
    [lk_R,fv_R]=rec_compute_lk_empty_col(node.Right,Pi,map);
    
    fv=(node.Left.Pr*fv_L) .* (node.Right.Pr*fv_R);
    
    %lk=node.iota*node.beta*sum(Pi.*fv)+lk_L+lk_R;
    lk=node.iota*(1+(node.beta*(-1+sum(Pi.*fv))))+lk_L+lk_R;
end