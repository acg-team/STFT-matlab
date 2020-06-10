function pi_1=standardize_sequences_DNA(pi_1)

vm1=mean(pi_1,2);
vstd1=std(pi_1,2);

pi_1=(pi_1-vm1)/vstd1;



