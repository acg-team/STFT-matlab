function x=padd_seq_with_value(x,l,direction,val)

N=size(x,1);

pad=repmat(val,[N,l]);

if strcmp(direction,'right')
    x=[x,pad];
elseif strcmp(direction,'left')
    x=[pad,x];
else
    error('ERROR: direction not recognized')
end