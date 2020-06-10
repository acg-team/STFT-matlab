function x=add_cell(c,y,dir)

if size(c,1)>1 && size(c,2)>1
    error('ERROR in add_cell')
end

if dir==1
    x=cell(length(c)+1,1);
else
    x=cell(1,length(c)+1);
end

for i=1:length(c)
    x{i}=c{i};
end
x{length(c)+1}=y;

% display('.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-')
% display('cell vector')
% x
% display('.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-')
