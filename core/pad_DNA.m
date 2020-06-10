function [piA_1,piC_1,piG_1,piT_1,piE_1,piA_2,piC_2,piG_2,piT_2,piE_2]=pad_DNA(piA_1,piC_1,piG_1,piT_1,piE_1,piA_2,piC_2,piG_2,piT_2,piE_2,approach)

l1=size(piA_1,2);
l2=size(piA_2,2);
if strcmp(approach,'correlation')
    pad_val_vA_1=0;
    pad_val_vC_1=0;
    pad_val_vG_1=0;
    pad_val_vT_1=0;
    pad_val_vE_1=0;
    
    pad_val_vA_2=0;
    pad_val_vC_2=0;
    pad_val_vG_2=0;
    pad_val_vT_2=0;
    pad_val_vE_2=0;
elseif strcmp(approach,'grantham')
    pad_val_vA_1=mean(piA_1);
    pad_val_vC_1=mean(piC_1);
    pad_val_vG_1=mean(piG_1);
    pad_val_vT_1=mean(piT_1);
    pad_val_vE_1=mean(piE_1);
    
    pad_val_vA_2=mean(piA_2);
    pad_val_vC_2=mean(piC_2);
    pad_val_vG_2=mean(piG_2);
    pad_val_vT_2=mean(piT_2);
    pad_val_vE_2=mean(piE_2);
end

if l1==l2
    
elseif l1<l2
    pad_length=l2-l1;
    piA_1=padd_seq_with_value_AA(piA_1,pad_length,'right',pad_val_vA_1);
    piC_1=padd_seq_with_value_AA(piC_1,pad_length,'right',pad_val_vC_1);
    piG_1=padd_seq_with_value_AA(piG_1,pad_length,'right',pad_val_vG_1);
    piT_1=padd_seq_with_value_AA(piT_1,pad_length,'right',pad_val_vT_1);
    piE_1=padd_seq_with_value_AA(piE_1,pad_length,'right',pad_val_vE_1);
elseif l1>l2
    pad_length=l1-l2;
    piA_2=padd_seq_with_value_AA(piA_2,pad_length,'right',pad_val_vA_2);
    piC_2=padd_seq_with_value_AA(piC_2,pad_length,'right',pad_val_vC_2);
    piG_2=padd_seq_with_value_AA(piG_2,pad_length,'right',pad_val_vG_2);
    piT_2=padd_seq_with_value_AA(piT_2,pad_length,'right',pad_val_vT_2);
    piE_2=padd_seq_with_value_AA(piE_2,pad_length,'right',pad_val_vE_2);
end

l1_after_pad=size(piA_1,2);
l2_after_pad=size(piA_2,2);
if l1_after_pad ~= l2_after_pad
   error('ERROR in pad_DNA') 
end
