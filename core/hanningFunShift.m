function x = hanningFunShift(hanSize,centerpoint,sigSize)

x=[hann(hanSize)',zeros(1,sigSize-hanSize)];

x=circshift(x,centerpoint-floor(hanSize/2));