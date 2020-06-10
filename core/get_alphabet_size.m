function [alphabet_size,extended_alphabet_size]=get_alphabet_size(type)

if strcmp(type,'DNA')
    alphabet_size=4;
    extended_alphabet_size=alphabet_size+1;
elseif strcmp(type,'AA')
    alphabet_size=20;
    extended_alphabet_size=alphabet_size+1;
else
    error('alphabet not implemented')
end