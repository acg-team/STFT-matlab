function coords=get_best_path_v2(p)

max_score=-inf;
for k=1:size(p,1)
    s=0;
    for i=1:length(p{k}.path)
        s=s+ (p{k}.blocks(i,2)-p{k}.blocks(i,1)+1);
    end
    if s>max_score
        max_score=s;
        max_k=k;
    end
end

coords=p{max_k}.blocks;