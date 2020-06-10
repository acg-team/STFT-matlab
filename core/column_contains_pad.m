function b=column_contains_pad(c,map)

b=false;
for i=1:length(c)
    if not(isKey(map,c(i)))
        b=true;
        break
    end
end
