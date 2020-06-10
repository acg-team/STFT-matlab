function x=padd_seq_DNA(x,l,direction,type)

N=size(x,1);

if strcmp(type,'char')
    pad=repmat(blanks(l),N);
elseif strcmp(type,'double')
    alphabet_size=size(x,1);
    pad=zeros(alphabet_size,l);
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