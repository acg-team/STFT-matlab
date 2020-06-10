function [f_path,f_lk,f_blocks] = connect_sub_solutions(f)

if length(f)==1
    
    f_path=f{1}.path;
    f_lk=f{1}.lk;
    f_blocks=f{1}.blocks;

else
    
    p1=f{1}.path;
    lk1=f{1}.lk;
    b1=f{1}.blocks;
    
    for i=2:length(f)
        
        f{i}
        
        p2=f{i}.path;
        lk2=f{i}.lk;
        b2=f{i}.blocks;
        
        [p,lk,b]=compose_solution(p1,p2,lk1,lk2,b1,b2);
        
        p1=p;
        lk1=lk;
        b1=b;
        
    end
    
    f_path=p;
    f_lk=lk;
    f_blocks=b;

end