function lk=lk_col(node,col_i,col_j)

if node.is_leaf
    
else
    
    assign_char_to_leaf(node.Left,col_i,1);
    assign_char_to_leaf(node.Right,col_j,1);
    
    fvL=rec_compute_fv_match(node.Left,extended_alphabet_size,Q,map);
    fvR=rec_compute_fv_match(node.Right,extended_alphabet_size,Q,map);
    fv=expm(node.Left.br_l*Q)*fvL.*expm(node.Right.br_l*Q)*fvR;
    
    [fvL,lk_down]=rec_compute_fv_match(node,extended_alphabet_size,Q,map);
    [fvR,lk_down]=rec_compute_fv_match(node,extended_alphabet_size,Q,map);
    
    fv0=expm(node.Left.br_l*Q)*fvL.*expm(node.Right.br_l*Q)*fvR;
    
    lk=node.iota*node.beta*sum(Pi.*fv0);
end



