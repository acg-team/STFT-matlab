function ck=compute_correlation_fft_DNA(vA1,vA2,vC1,vC2,vG1,vG2,vT1,vT2,vE1,vE2)

c_A=ifft(conj(fft(vA1)).*fft(vA2)); 
c_C=ifft(conj(fft(vC1)).*fft(vC2)); 
c_G=ifft(conj(fft(vG1)).*fft(vG2)); 
c_T=ifft(conj(fft(vT1)).*fft(vT2)); 
c_E=ifft(conj(fft(vE1)).*fft(vE2)); 

ck=c_A+c_C+c_G+c_T+c_E; 