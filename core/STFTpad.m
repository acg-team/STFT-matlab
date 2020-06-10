function [Z,W,T]=STFTpad(N,v1,v2,p1,p2,c1,c2,L,p,sizeH,FIR,delta)

[w_ori,scale,range]=getSTFTfilter(FIR,L,sizeH,delta);

v1p=[fliplr(v1(1+1:sizeH/2+1)),v1,fliplr(v1(end-sizeH/2:end-1))];
v2p=[fliplr(v2(1+1:sizeH/2+1)),v2,fliplr(v2(end-sizeH/2:end-1))];
p1p=[fliplr(c1(1+1:sizeH/2+1)),p1,fliplr(p1(end-sizeH/2:end-1))];
p2p=[fliplr(c2(1+1:sizeH/2+1)),p2,fliplr(p2(end-sizeH/2:end-1))];
c1p=[fliplr(p1(1+1:sizeH/2+1)),c1,fliplr(c1(end-sizeH/2:end-1))];
c2p=[fliplr(p2(1+1:sizeH/2+1)),c2,fliplr(c2(end-sizeH/2:end-1))];

Len=L+sizeH;
[Z,T,W]=runSTFT(N,v1p,v2p,p1p,p2p,c1p,c2p,range,Len,w_ori,scale,p);

Z=Z(:,sizeH/2+1:sizeH/2+L);
