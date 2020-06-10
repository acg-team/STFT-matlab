function [blocks,lk_c]=prefilter(blocks,lk_c)

flag=true;
while (flag)
    flag=false;
    for i=1:size(blocks,1)-1
        
        b1=blocks(i,:);
        
        for j=i+1:size(blocks,1)
            
            b2=blocks(j,:);
            
            if b1(1)<=b2(1) & b1(2)>=b2(2) & b1(3)<=b2(3) & b1(4)>=b2(4)
                %remove b2
                idx=i;
                flag=true;
            elseif b2(1)<=b1(1) & b2(2)>=b1(2) & b2(3)<=b1(3) & b2(4)>=b1(4)
                %remove b1
                idx=j;
                flag=true;
            end
            
            if flag
                blocks(idx,:)=[];
                lk_c(idx)=[];
                break;
            end
            
        end
        
        if flag
            break
        end
        
    end
end