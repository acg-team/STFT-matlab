function b=all_gaps(column)

b=true;
for i=1:length(column)
    if not(isequal(column(i),'-'))
       b=false;
       break;
    end
end