function fv=rec_compute_fv(node,char_idx)

if node.is_leaf
    extended_alphabet_size=size(node.Pr,1);
    fv=zeros(extended_alphabet_size,1);
    fv(char_idx)=1;
else
    fvL=rec_compute_fv(node.Left,char_idx);
    fvR=rec_compute_fv(node.Right,char_idx);
    
    fv=(node.Left.Pr*fvL) .* (node.Right.Pr*fvR);
end