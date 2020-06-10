function [p,lk,b]=compose_solution(p1,p2,lk1,lk2,b1,b2)

p=[];
lk={};
b=[];
for i=1:length(p1)
    if p1(i)~=p2(1)
        p=[p,p1(i)];
        lk=add_cell(lk,lk1{i},1);
        b=[b;b1(i,:)];
    else
        break;
    end
end

for i=1:length(p2)
    p=[p,p2(i)];
    lk=add_cell(lk,lk2{i},1);
    b=[b;b2(i,:)];
end

