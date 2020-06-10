function [jarray,lk_c,fpath]=sort_data(jarray,lk_c,fpath)

if isempty(jarray)
    error('array is empty')
else
    [~,idx_sort]=sort(jarray(:,1),'asc');
    
    jarray=jarray(idx_sort,:);
    lk_c=lk_c(idx_sort);
    
    if not(isempty(fpath)) 
        fpath=fpath(idx_sort);
    end
    
    % transpose lk_c
    if size(lk_c,2)>size(lk_c,1)
        lk_c = lk_c';
    end
    
end