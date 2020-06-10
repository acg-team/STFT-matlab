function blocks=prefilter_v2(blocks)

flag=true;
while (flag)
    
    flag=false;
    
    for i=1:size(blocks,1)-1
        
        block1=blocks(i,:);
        a1=block1(1);
        b1=block1(2);
        c1=block1(3);
        d1=block1(4);
        
        for j=i+1:size(blocks,1)
            
            block2=blocks(j,:);
            a2=block2(1);
            b2=block2(2);
            c2=block2(3);
            d2=block2(4);
        
            %if block1(1)<=block2(1) & block1(2)>=block2(2) & block1(3)<=block2(3) & block1(4)>=block2(4)
            if a1<=a2 & b1>=b2 & c1<=c2 & d1>=d2
                %remove b2
                idx=i;
                flag=true;
            %elseif block2(1)<=block1(1) & block2(2)>=block1(2) & block2(3)<=block1(3) & block2(4)>=block1(4)
            elseif a2<=a1 & b2>=b1 & c2<=c1 & d2>=d1
                %remove b1
                idx=j;
                flag=true;
            end
            
            if flag
                blocks(idx,:)=[];
                break;
            end
            
        end
        
        if flag
            break
        end
        
    end
end