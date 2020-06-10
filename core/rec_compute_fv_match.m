function fv=rec_compute_fv_match(node,map)

if node.is_leaf
    extended_alphabet_size=size(node.Pr,1);
    fv=zeros(extended_alphabet_size,1);     
    char_idx=map(node.ch);
    fv(char_idx)=1;
else
    fvL=rec_compute_fv_match(node.Left,map);
    fvR=rec_compute_fv_match(node.Right,map);

    fv=(node.Left.Pr*fvL) .* (node.Right.Pr*fvR);
end