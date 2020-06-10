function [val,idx]=get_max_of_three(m,x,y)

eps=1e-10;

if abs(m-x)<eps && abs(m-y)<eps && abs(x-y)<eps 
    idx=randi(3);
    v=[m,x,y];
    val=v(idx);
elseif abs(m-x)<eps && m>y && x>y   
    r=rand(1);
    if r<0.5
        val=m; idx=1;
    else
        val=x; idx=2;
    end
elseif abs(m-y)<eps && m>x && y>x
    r=rand(1);
    if r<0.5
        val=m; idx=1;
    else
        val=y; idx=3;
    end    
elseif abs(x-y)<eps && x>m && y>m
    r=rand(1);
    if r<0.5
        val=x; idx=2;
    else
        val=y; idx=3;
    end  
else
    [val,idx]=max([m,x,y]);
    
    flag=true;
end
