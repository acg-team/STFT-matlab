function coords=filter_blocks(coords,l1,l2,min_segment_length)

% if (coords(1,1))<min_segment_length || ...
%         (coords(1,3))<min_segment_length
%     coords(1,1)=1;
%     coords(1,3)=1;
% end
% if l1-coords(end,2) < min_segment_length || ...
%         l2-coords(end,4) < min_segment_length
%     coords(end,2)=l1;
%     coords(end,4)=l2;
% end

flag=true;
while flag
    flag=false;
    
    nblocks = size(coords,1);
    
    for i=2:nblocks
        if  (coords(i,1) - coords(i-1,2)) < min_segment_length || ...
                (coords(i,3) - coords(i-1,4)) < min_segment_length
            coords(i-1,:) = [coords(i-1,1) coords(i,2) coords(i-1,3) coords(i,4)];
            coords(i,:) = [];
            flag=true;
            break
        end
    end
    
end