function [f_last,f_prev,flag]=update_last_pair(p_this,f_prev,flag)

if length(p_this.path)==2
    
    f_last.path=p_this.path;
    f_last.lk=p_this.lk;
    f_last.blocks=p_this.blocks;
    
else
    
    % length(p_this.path) == 1
    
    if length(f_prev.path)==2
        
        if f_prev.path(2) ~= p_this.path(1)
            % remove second block in second-to-last element
            f_prev.path = f_prev.path(1);
            lk = cell(1,1);
            lk{1} = f_prev.lk{1};
            f_prev.lk = lk;
            f_prev.blocks = f_prev.blocks(1,:);
        end
        
        f_last.path=p_this.path;
        f_last.lk=p_this.lk;
        f_last.blocks=p_this.blocks;
        
    else
        % penultimo ha 1 solo blocco e ultimo
        % pure per cui vengono processati
        % insieme
        
        new_pair.path=[f_prev.path(1),p_this.path(1)];
        lk=cell(2,1);
        lk{1}=f_prev.lk{1};
        lk{2}=p_this.lk{1};
        new_pair.lk=lk;
        new_pair.blocks=[f_prev.blocks(1,:);
            p_this.blocks(1,:)];
        
        [pair_out,flag]=solve_pairs(new_pair);
        
        if length(pair_out.path)==2
            f_prev.path=pair_out.path(1);
            lk=cell(1,1);
            lk{1}=pair_out.lk{1};
            f_prev.lk=lk;
            f_prev.blocks=pair_out.blocks(1,:);
            
            f_last.path=pair_out.path(2);
            lk=cell(1,1);
            lk{1}=pair_out.lk{2};
            f_last.lk=lk;
            f_last.blocks=pair_out.blocks(2,:);
        else
            f_prev.path=pair_out.path(1);
            lk=cell(1,1);
            lk{1}=pair_out.lk{1};
            f_prev.lk=lk;
            f_prev.blocks=pair_out.blocks(1,:);
            
            f_last.path=[];
            f_last.lk=[];
            f_last.blocks=[];
        end
        
    end
    
end
