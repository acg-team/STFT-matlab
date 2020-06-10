function [ck_idx,centers]=sfft_blocks(Z,th,symbol)

Zpad=th*ones(size(Z,1)+2,size(Z,2)+2);
Zpad(2:end-1,2:end-1)=Z;

ck_idx=[];
centers=[];
for i=1:size(Zpad,2)
    
    x=Zpad(:,i);
    
    if symbol == '>'
        y=int32(x>th);
    else
        y=int32(x<th);
    end
    
    
    if sum(y)>0
        
        start_end=abs(y(2:end)-y(1:end-1));
        
        indeces=1:length(start_end);
        start_end_idx=indeces(start_end==1);
        
        starts=transp(start_end_idx(1:2:end));
        ends=transp(start_end_idx(2:2:end)-1);
        
        if ~isempty(starts) && ~isempty(ends)
            ck_idx = [ ck_idx ; repmat(i-1,[size(starts,1),1]) ];
            centers=[ centers ; [starts,ends] ];
        end
        
    end
    
end