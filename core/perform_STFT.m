function [Z,W]=perform_STFT(v1,v2,p1,p2,c1,c2,L,w_ori,scale,range)

Z=zeros(length(range),L);
W=zeros(length(range),L);

k=1;
for i=range
    
    w=circshift(w_ori,i);
    
    vz2 = w(1:L) .* v2;
    pz2 = w(1:L) .* p2;
    cz2 = w(1:L) .* c2;
    
    %-----------------------------------
    vy=ifft( fft(fliplr(v1)) .* fft(vz2) );
    py=ifft( fft(fliplr(p1)) .* fft(pz2) );
    cy=ifft( fft(fliplr(c1)) .* fft(cz2) );
    Z(k,:)=(scale)*(vy+py+cy);
    W(k,:)=w(1:L);
    %-----------------------------------
    
    k=k+1;
end