function p = fill_path_data_v2(p,blocks,num_path)

for k=1:num_path
    len_path=length(p{k}.path);
    p{k}.blocks=zeros(len_path,4);
    for i=1:len_path
        ti=p{k}.path(i);
        p{k}.blocks(i,:)=blocks(ti,:);
    end
end