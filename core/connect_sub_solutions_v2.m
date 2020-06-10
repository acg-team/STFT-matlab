function [f_path,f_lk,f_blocks] = connect_sub_solutions_v2(f)

if length(f)==1
    
    f_path=[];
    f_lk=[];
    f_blocks=[];
    for j=1:length(f{1})
        f_path = [f_path,f{1}{j}.path];
        f_lk{end+1} = f{1}{j}.lk;
        f_blocks =[f_blocks ; f{1}{j}.blocks];
    end
    
else
    
    f_path=[];
    f_lk=[];
    f_blocks=[];
    for i=1:length(f)
        for j=1:length(f{i})
            f_path = [f_path,f{i}{j}.path];
            f_lk{end+1} = f{i}{j}.lk;
            f_blocks =[f_blocks ; f{i}{j}.blocks];
        end
    end
    
    bool_replica = false(1,length(f_path));
    for i=2:length(f_path)
        if f_path(i)==f_path(i-1)
            bool_replica(i-1)=true;
        end
    end
    
    f_path(bool_replica)=[];
    f_blocks(bool_replica,:)=[];
    f_lk(bool_replica) = [];

end