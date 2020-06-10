function [gappy_s1,gappy_s2]=get_gappy_segments2(seq1,seq2,gl1,gr1,gl2,gr2,type,coords1,coords2,len,params,l1,l2)

% display('-------------------')
% display('get_gappy_segments2')
% SEQ1=seq1
% SEQ2=seq2
% GL1=gl1
% GR1=gr1
% GL2=gl2
% GR2=gr2
% C1=coords1
% C2=coords2
% display('-------------------')


%seq1,seq2,gl1,gr1,gl2,gr2

if strcmp(type,'first')
    a=1;
    b=coords1(1)-1;
    gappy_s1=[gl1,seq1(:,a:b),gr1];
    
    a=1+l1;
    b=coords1(3)-1;
    gappy_s2=[gl2,seq2(:,a:b),gr2];
elseif strcmp(type,'intermediate')
    a=coords1(2)+1;
    b=coords2(1)-1;
    gappy_s1=[gl1,seq1(:,a:b),gr1];
    
    a=coords1(4)+1;
    b=coords2(3)-1;
    gappy_s2=[gl2,seq2(:,a:b),gr2];
elseif strcmp(type,'last')
    a=coords2(2)+1;
    b=l1;
    gappy_s1=[gl1,seq1(:,a:b),gr1];
    
    a=coords2(4)+1;
    b=l1+l2;
    gappy_s2=[gl2,seq2(:,a:b),gr2];   
else
    error('type not recognized')
end


