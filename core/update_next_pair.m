function p_next=update_next_pair(p_this,p_next)

if length(p_this.path)==1

    p_next.path=p_next.path(2);
    
    lk=cell(1,1);
    lk{1}=p_next.lk{2};
    p_next.lk=lk;
    
    p_next.blocks=p_next.blocks(2,:);
    
else
    
    if p_this.path(2)  ~= p_next.path(1)
        [p_this.path.path(2),p_next.path.path(1)]
        error('ERROR in update_next_pair')
    end
    
    p_next.path=[p_this.path(2),p_next.path(2)];
    
    lk=cell(2,1);
    lk{1}=p_this.lk{2};
    lk{2}=p_next.lk{2};
    p_next.lk=lk;
    
    p_next.blocks=[p_this.blocks(2,:);
                   p_next.blocks(2,:)];

end