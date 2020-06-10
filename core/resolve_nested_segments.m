function jarray=resolve_nested_segments(overlap,jarray)

for k=1:size(overlap,1)
    if strcmp(overlap{k}.type,'nested')
        idx_i=overlap{k}.ij(1);
        idx_j=overlap{k}.ij(2);
        
        lk1=jarray(idx_i,3);
        lk2=jarray(idx_j,3);

        if lk1>lk2
            jarray(idx_j,:)=[];
        else
            jarray(idx_i,:)=[];
        end
    end
end