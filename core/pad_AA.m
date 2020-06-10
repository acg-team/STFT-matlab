function [v1,p1,c1,v2,p2,c2]=pad_AA(v1,p1,c1,v2,p2,c2,approach)

l1=size(v1,2);
l2=size(v2,2);
if strcmp(approach,'correlation')
    pad_val_v1=0;
    pad_val_p1=0;
    pad_val_c1=0;
    
    pad_val_v2=0;
    pad_val_p2=0;
    pad_val_c2=0;
elseif strcmp(approach,'grantham')
    pad_val_v1=mean(v1);
    pad_val_p1=mean(p1);
    pad_val_c1=mean(c1);
    
    pad_val_v2=mean(v2);
    pad_val_p2=mean(p2);
    pad_val_c2=mean(c2);
end

if l1==l2
    
elseif l1<l2
    pad_length=l2-l1;
    v1=padd_seq_with_value_AA(v1,pad_length,'right',pad_val_v1);
    p1=padd_seq_with_value_AA(p1,pad_length,'right',pad_val_p1);
    c1=padd_seq_with_value_AA(c1,pad_length,'right',pad_val_c1);
elseif l1>l2
    pad_length=l1-l2;
    v2=padd_seq_with_value_AA(v2,pad_length,'right',pad_val_v2);
    p2=padd_seq_with_value_AA(p2,pad_length,'right',pad_val_p2);
    c2=padd_seq_with_value_AA(c2,pad_length,'right',pad_val_c2);
end

l1_after_pad=size(v1,2);
l2_after_pad=size(v2,2);
if l1_after_pad ~= l2_after_pad
   error('ERROR in pad_AA') 
end
