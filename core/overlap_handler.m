function jarray=overlap_handler(jarray)

flag=false;
while(not(flag))
    
    flag=true;
    
    for k=1:size(jarray,1)-1
        lag_k1=jarray(k,4);
        lag_k2=jarray(k+1,4);
        
        %[a1,b1,a2,b2]=get_bound_segments(lag_k1,l1,l2);
        %[c1,d1,c2,d2]=get_bound_segments(lag_k2,l1,l2);
        
        a1=jarray(k,1);
        b1=jarray(k,2);
        a2=a1+jarray(k,4)-1;
        b2=b1+jarray(k,4)-1;
        c1=jarray(k+1,1);
        d1=jarray(k+1,2);
        c2=a1+jarray(k+1,4)-1;
        d2=b1+jarray(k+1,4)-1;
        
        type=overlap_type(a1,b1,a2,b2,c1,d1,c2,d2)
        
        if strcmp(type,'normal')
            flag=true;
        else
            
            [a1,b1,a2,b2]
            [c1,d1,c2,d2]
            
            S=resolve_overlap(type,a1,b1,a2,b2,c1,d1,c2,d2);
            %S=[S,zeros(size(S,1),1)];
            

            
            flag=false;
        end
        
        if not(flag)
            if k>1
                jarray_pre=jarray(1:k-1,:);
            else
                jarray_pre=[];
            end
            if size(jarray,1)>k+1
                jarray_post=jarray(k+2:end,:);
            else
                jarray_post=[];
            end
            
            if size(S,1)==1
                cs=[S(:,1:2),jarray(k,3:4)];
            else
                cs=[S(:,1:2),jarray(k:k+1,3:4)];
            end
            
            jarray=[jarray_pre;cs;jarray_post];
        end
        
        if not(flag)
            break;
        end
    end
end