function [v1,v2,p1,p2,c1,c2]=standardize_AA(v1,v2,p1,p2,c1,c2)

v1=standardize_sequences_AA(v1);
p1=standardize_sequences_AA(p1);
c1=standardize_sequences_AA(c1);

v2=standardize_sequences_AA(v2);
p2=standardize_sequences_AA(p2);
c2=standardize_sequences_AA(c2);