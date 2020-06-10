function b=is_gappy(column)

b=false;
for i=1:length(column)
    if isequal(column(i),'-')
       b=true;
       break;
    end
end