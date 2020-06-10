function jarray=resolve_overlapping_segments(overlap,jarray)

for k=1:size(overlap,1)
    if strcmp(overlap{k}.type,'overlap')
        a1=overlap{k}.seg1(1);
        b1=overlap{k}.seg2(1);
        a2=overlap{k}.seg1(2);
        b2=overlap{k}.seg2(2);
        idx_i=overlap{k}.ij(1);
        idx_j=overlap{k}.ij(2);
        
        jarray(idx_i,1)=a1;
        jarray(idx_i,2)=b1;
        jarray(idx_j,1)=a2;
        jarray(idx_j,2)=b2;
    end
end