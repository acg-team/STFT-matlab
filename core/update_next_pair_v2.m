function p_next=update_next_pair_v2(p_this,p_next)

if length(p_this)==1

    p_next{1}=p_this{1};
    
else
       
    p_next{1}=p_this{2};
    
end