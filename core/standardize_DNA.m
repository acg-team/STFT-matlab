function [piA_1,piA_2,piC_1,piC_2,piG_1,piG_2,piT_1,piT_2,piE_1,piE_2]=standardize_DNA(piA_1,piA_2,piC_1,piC_2,piG_1,piG_2,piT_1,piT_2,piE_1,piE_2)

piA_1=standardize_sequences_DNA(piA_1);
piC_1=standardize_sequences_DNA(piC_1);
piG_1=standardize_sequences_DNA(piG_1);
piT_1=standardize_sequences_DNA(piT_1);
piE_1=standardize_sequences_DNA(piE_1);

piA_2=standardize_sequences_DNA(piA_2);
piC_2=standardize_sequences_DNA(piC_2);
piG_2=standardize_sequences_DNA(piG_2);
piT_2=standardize_sequences_DNA(piT_2);
piE_2=standardize_sequences_DNA(piE_2);