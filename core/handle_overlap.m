overlap=detect_problematic_segments(jarray,l1,l2);
% jarray=resolve_overlapping_segments(overlap,jarray);
% jarray=resolve_indentical_segments(overlap,jarray);
% jarray=resolve_nested_segments(overlap,jarray);

if not(isempty(overlap))
    warning('Warning: overlapping regions')
    
    bool_eliminate_j=false(size(jarray,1),1);
    bool_eliminate_o=false(size(overlap,1),1);
    for k=1:size(overlap,1)
        if strcmp(overlap{k}.type,'to_be_selected')
            idx_i=overlap{k}.ij(1);
            idx_j=overlap{k}.ij(2);
            if jarray(idx_i,3)>jarray(idx_j,3)
                bool_eliminate_j(idx_j)=true;
            else
                bool_eliminate_j(idx_i)=true;
            end
            bool_eliminate_o(k)=true;
        end
    end
    
    jarray(bool_eliminate_j,:)=[];
    overlap(bool_eliminate_o)=[];
    
end

if not(isempty(overlap))
    error('ERROR: overlapping regions')
end