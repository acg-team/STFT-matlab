function [jarray,lk_c,d_shift]=store_homologous_blocks(jarray,lk_c,d_shift,starts,ends,offset,log_lk_v,lag_k)

i_lk = length(lk_c)+1;
for i=1:length(starts)
    a=starts(i)+offset;
    b=ends(i)+offset;
    
    lk_c{i_lk}=log_lk_v(starts(i):ends(i));
    i_lk=i_lk+1;
    
    jarray=[jarray;[a,b,0,lag_k]];
    
    d_shift=[d_shift;l1];
end