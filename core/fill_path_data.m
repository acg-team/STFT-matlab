function p = fill_path_data(p,lk_c,blocks,num_path)

for k=1:num_path
    len_path=length(p{k}.path);
    p{k}.lk=cell(len_path,1);
    p{k}.blocks=zeros(len_path,4);
    for i=1:len_path
        ti=p{k}.path(i);
        p{k}.lk{i}=lk_c{ti};
        p{k}.blocks(i,:)=blocks(ti,:);
    end
end