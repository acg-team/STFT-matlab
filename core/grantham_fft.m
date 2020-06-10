function y=grantham_fft(x1,x2)

y=( ( -2*ifft( fft(fliplr(x1)) .* fft(x2) ) ) + sum(x1.^2) +sum(x2.^2) );



% x1=x1-mean(x1);
% x2=x2-mean(x2);
% n = size(x1,2);
% H = hann(n);
% H = H';
% W0 = fft(H);
% W1conj = fft(fliplr(H));
% S1conj = fft(fliplr(H .* x2.^2));
% S0 = fft(H .* x1.^2);
% I0I1 = fft(H .* x1) .* fft(fliplr(H .* x2)) ;
% 
% y = W0.*S1conj + S0 .* W1conj -2*ifft(I0I1);

