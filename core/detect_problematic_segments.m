function overlap=detect_problematic_segments(jarray,l1,l2)

num_seg=size(jarray,1);

overlap=[];
idx=1;
for i=1:num_seg-1
    
    lag_k=jarray(i,4);
    %[a1,b1,a2,b2]=get_bound_segments(lag_k,l1,l2)
    
    a1=jarray(i,1);
    b1=jarray(i,2);
    a2=a1+lag_k-l1;
    b2=b1+lag_k-l1;
    
    %     a1=jarray(i,1);
    %     b1=jarray(i,2);
    
    for j=i+1:num_seg
        
        lag_k=jarray(j,4);
        %[c1,d1,c2,d2]=get_bound_segments(lag_k,l1,l2)
        
        c1=jarray(j,1);
        d1=jarray(j,2);
        c2=c1+lag_k-l1;
        d2=d1+lag_k-l1;
        
        %         a2=jarray(j,1);
        %         b2=jarray(j,2);
        
        if (c1>=b1) && (c2>=b2)
            %normality (no overlap)
        elseif(c1<b1 && c2<b2 && d2>b2 && d1>b1)
            %             overlap{idx}.seg1=[jarray(i,1),jarray(i,2)];
            %             overlap{idx}.seg2=[jarray(j,1),jarray(j,2)];
            overlap{idx}.type='overlap';
            overlap{idx}.ij=[i,j];
            idx=idx+1;
        else
            overlap{idx}.type='to_be_selected';
            overlap{idx}.ij=[i,j];
            idx=idx+1;
        end
        
        %             if a1==a2 && b1==b2
        %                 %identical
        %                 overlap{idx}.seg1=[jarray(i,1),jarray(i,2)];
        %                 overlap{idx}.seg2=[jarray(j,1),jarray(j,2)];
        %                 overlap{idx}.type='identical';
        %                 overlap{idx}.ij=[i,j];
        %             elseif b2<=b1
        %                 %nested
        %                 overlap{idx}.seg1=[jarray(i,1),jarray(i,2)];
        %                 overlap{idx}.seg2=[jarray(j,1),jarray(j,2)];
        %                 overlap{idx}.type='nested';
        %                 overlap{idx}.ij=[i,j];
        %             else
        %                 %overlap
        %                 overlap{idx}.seg1=[jarray(i,1),jarray(i,2)];
        %                 overlap{idx}.seg2=[jarray(j,1),jarray(j,2)];
        %                 overlap{idx}.type='overlap';
        %                 overlap{idx}.ij=[i,j];
        %             end
        %
        %             idx=idx+1;
        %         end
    end
end



