function [w_ori,scale,range]=getSTFTfilter(FIR,L,sizeH,delta)

switch FIR
    case 'gauss'
        F=gausswin(sizeH);
    case 'hann'
        F=hann(sizeH);
    case 'bar'
        F=barthannwin(sizeH);
    case 'blac'
        F=blackman(sizeH);
    case 'boh'
        F=bohmanwin(sizeH);
    case 'tri'
        F=triang(sizeH);
    case 'fla'
        F=flattopwin(sizeH);
    case 'rect'
        F=rectwin(sizeH);
    case 'welch'
        F=welchwin(sizeH-1);
        F=[F;F(1)];
    otherwise
end
%%
% w_ori = [zeros(1,L),F'];
% 
% w_ori = circshift(w_ori,-1);
% 
% scale = (1/sum(F));
% 
% %range = 0+sizeH/2 : delta : L+sizeH+sizeH/2-1;
% %range = 0 : delta : L+sizeH-1;
% range = 1 : delta : L+sizeH;
%%
% w_ori = [zeros(1,L-sizeH),F'];
% 
% %w_ori = circshift(w_ori,sizeH/2-1);
% 
% scale = (1/sum(F));
% 
% %range = 0+sizeH/2 : delta : L+sizeH+sizeH/2-1;
% %range = 0 : delta : L+sizeH-1;
% range = 1 : delta : L+sizeH;
%%
w_ori = [zeros(1,L),F'];
w_ori = circshift(w_ori,sizeH/2);
range = 1 : delta : L+sizeH;
scale = (1/sum(F));





