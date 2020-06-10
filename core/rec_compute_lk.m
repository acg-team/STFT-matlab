function [lk,fv,all_gaps]=rec_compute_lk(node,Pi,map)

if node.is_leaf
    
    if strcmp(node.ch,'-')
        all_gaps=true;
    else
        all_gaps=false;
    end
    
    extended_alphabet_size=size(node.Pr,1);
    fv=zeros(extended_alphabet_size,1);
    
    char_idx=map(node.ch);
    fv(char_idx)=1;
    
    lk=node.iota*node.beta*sum(Pi.*fv);
else
    [lk_L,fv_L,all_gaps_L]=rec_compute_lk(node.Left,Pi,map);
    [lk_R,fv_R,all_gaps_R]=rec_compute_lk(node.Right,Pi,map);
    
    all_gaps=(all_gaps_L & all_gaps_R);
    
    fv=(node.Left.Pr*fv_L) .* (node.Right.Pr*fv_R);
    
    lk=node.iota*node.beta*sum(Pi.*fv);
    
    if all_gaps_L==true && all_gaps_R==false
        lk=lk+lk_R;
    elseif all_gaps_R==true && all_gaps_L==false
        lk=lk+lk_L;
    end
    
end