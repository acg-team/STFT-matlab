function code=region2code(a,b,c,d)
%%
[a,b,c,d]=pixel2line(a,b,c,d);
%%
if a>=b
    error('ERROR: length <=0')
end

if c>=d
    error('ERROR: length <=0')
end
%%
%--------------------------
% "normal cases"
%-------------------------
if c==a && d<b
    code=1;
elseif c==a && d==b
    code=2;
elseif c==a && d>b
    code=3; 
elseif c>a && c<b && d<b
    code=4; 
elseif c>a && c<b && d==b
    code=5;   
elseif c>a && c<b && d>b
    code=6;  
elseif c==b && d>b
    code=7;  
elseif c>b && d>b
    code=8;   
%-------------------------
%  these below should in 
%  principle never appear
%-------------------------
elseif c<a && d<a
    code=9;  
elseif c<a && d==a
    code=10;
elseif c<a && d>a && d<b
    code=11;
elseif c<a && d==b
    code=12;
elseif c<a && d>b
    code=13;         
else  
    %[a,b,c,d];
    code=999;
%-------------------------    
end





