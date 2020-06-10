function ck=compute_correlation_fft_AA(v1,v2,p1,p2,c1,c2)

% cv=ifft(conj(fft(v1)).*fft(v2)); 
% cp=ifft(conj(fft(p1)).*fft(p2)); 
% cc=ifft(conj(fft(c1)).*fft(c2));

cv=ifft(fft(fliplr(v1)).*fft(v2)); 
cp=ifft(fft(fliplr(p1)).*fft(p2)); 
cc=ifft(fft(fliplr(c1)).*fft(c2));

ck=cv+cp+cc;