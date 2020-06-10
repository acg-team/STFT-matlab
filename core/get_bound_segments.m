function [a1,b1,a2,b2]=get_bound_segments(lag_k,l1,l2)

if lag_k<=l1
    a1=l1+1-lag_k+1;
    a2=l1+1;

    num_char=min([l1-a1+1,l2]);

    b1=a1+num_char-1;
    b2=a2+num_char-1;
else        
    a1=1;
    a2=lag_k;

    num_char=min([l1-a1+1,(l2+l1)-a2+1]);

    b1=a1+num_char-1;
    b2=a2+num_char-1;
end

