function [coord,fpath]=sort_data_v2(coord,fpath)

if isempty(coord)
    error('array is empty')
else
    [~,idx_sort]=sort(coord(:,1),'asc');
    coord=coord(idx_sort,:);    
    
   if not(isempty(fpath)) 
        fpath=fpath(idx_sort);
    end
end