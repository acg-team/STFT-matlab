function coords=get_block_coordinates(jarray)

%% Block coordinates
%  
%     a2    b2
%  a1 +-----+ 
%     |     |
%     |     |
%  b1 +-----+ 
%     
%%
num_segments=size(jarray,1);
coords=zeros(num_segments,4);
for k=1:num_segments
    a1=jarray(k,1);
    b1=jarray(k,2);
    
    %a2=a1+jarray(k,4)-1;
    %b2=b1+jarray(k,4)-1;
    
    a2=a1+jarray(k,4)-1;
    b2=b1+jarray(k,4)-1;
    
    coords(k,:)=[a1,b1,a2,b2];
end