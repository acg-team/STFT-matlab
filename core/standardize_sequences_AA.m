function x=standardize_sequences_AA(x)

% vm=mean(volume);
% vstd=std(volume);
% pm=mean(polarity);
% pstd=std(polarity);

xm=mean(x);
xstd=std(x);

x=(x-xm)/xstd; 


