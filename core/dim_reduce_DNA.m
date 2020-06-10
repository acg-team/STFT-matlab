function [piA_1,piA_2,piC_1,piC_2,piG_1,piG_2,piT_1,piT_2,piE_1,piE_2]=dim_reduce_DNA(piA_1,piA_2,piC_1,piC_2,piG_1,piG_2,piT_1,piT_2,piE_1,piE_2)

piA_1=mean(piA_1,1);
piC_1=mean(piC_1,1);
piG_1=mean(piG_1,1);
piT_1=mean(piT_1,1);
piE_1=mean(piE_1,1);

piA_2=mean(piA_2,1);
piC_2=mean(piC_2,1);
piG_2=mean(piG_2,1);
piT_2=mean(piT_2,1);
piE_2=mean(piE_2,1);