function x=padd_seq_AA(x,l,direction,type,val)

N=size(x,1);

if strcmp(type,'char')
    pad=repmat(blanks(l),N);
elseif strcmp(type,'double')
    pad=val*ones(N,l);
else
    error('ERROR: type not recognized')
end

if strcmp(direction,'right')
    x=[x,pad];
elseif strcmp(direction,'left')
    x=[pad,x];
else
    error('ERROR: direction not recognized')
end