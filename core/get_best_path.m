function coords=get_best_path(p)

max_score=-inf;
for k=1:size(p,1)
    lk=p{k}.lk;
    s=0;
    for i=1:length(lk)
        %s=s+sum(lk{i});
        s=s+length(lk{i});
    end
    if s>max_score
        max_score=s;
        max_k=k;
    end
end

coords=p{max_k}.blocks;