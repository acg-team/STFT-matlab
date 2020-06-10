function S=check_is_square(S)

for i=1:size(S,1)
   
    l1=S(i,2)-S(i,1);
    l2=S(i,4)-S(i,3);
    
    l=min([l1,l2]);
    
    S(i,2)=S(i,1)+l;
    S(i,4)=S(i,3)+l;
    
end
