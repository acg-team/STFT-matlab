function minck = refine_coords_block2(cw,...
                                              ck,...
                                              L,...
                                              v1,...
                                              v2,...
                                              p1,...
                                              p2,...
                                              c1,...
                                              c2,...
                                              sizeH,...
                                              delta,...
                                              consecutive,...
                                              w_ori,...
                                              scale)

                                                                            
w_ori=circshift(w_ori,sizeH/2); %now the center of w_ori is at 0
%%
shift=cw;
w=circshift(w_ori,shift);
vz2=w(1:L) .* v2;
pz2=w(1:L) .* p2;
cz2=w(1:L) .* c2;
vy=ifft( fft(fliplr(v1)) .* fft(vz2) );
py=ifft( fft(fliplr(p1)) .* fft(pz2) );
cy=ifft( fft(fliplr(c1)) .* fft(cz2) );
Z31L=(scale)*(vy+py+cy);
val0=Z31L(ck);
%%
shift=min([cw + delta,L]);
w=circshift(w_ori,shift);
vz2=w(1:L) .* v2;
pz2=w(1:L) .* p2;
cz2=w(1:L) .* c2;
vy=ifft( fft(fliplr(v1)) .* fft(vz2) );
py=ifft( fft(fliplr(p1)) .* fft(pz2) );
cy=ifft( fft(fliplr(c1)) .* fft(cz2) );
Z31L=(scale)*(vy+py+cy);
val1=Z31L(ck);
%%
shift=max([cw - delta,1]);
w=circshift(w_ori,shift);
vz2=w(1:L) .* v2;
pz2=w(1:L) .* p2;
cz2=w(1:L) .* c2;
vy=ifft( fft(fliplr(v1)) .* fft(vz2) );
py=ifft( fft(fliplr(p1)) .* fft(pz2) );
cy=ifft( fft(fliplr(c1)) .* fft(cz2) );
Z31L=(scale)*(vy+py+cy);
val_1=Z31L(ck);
%%
[~,idx]=min([val_1,val0,val1]);
switch(idx)
    case 1
        k=-delta;
        shift=max([cw - delta,1]);
        ref_val=val_1;
    case 2
        if consecutive>1
            error('ERROR: not handled')
        end
        minck=cw;
        minval=val0;
        return;
    case 3
        k=+delta;
        shift=min([cw + delta,L]);
        ref_val=val1;
    otherwise
        error('ERROR')
end
%%
count=0;
flag=true;

shift=min([shift,L]);
shift=max([shift,1]);

minck = shift;
minval=ref_val;
while flag
    
    w=circshift(w_ori,shift);
    
    vz2=w(1:L) .* v2;
    pz2=w(1:L) .* p2;
    cz2=w(1:L) .* c2;
    vy=ifft( fft(fliplr(v1)) .* fft(vz2) );
    py=ifft( fft(fliplr(p1)) .* fft(pz2) );
    cy=ifft( fft(fliplr(c1)) .* fft(cz2) );
    Z31L=(scale)*(vy+py+cy);

    val=Z31L(ck);
    
    if val<ref_val
        
        if val<minval
            minval=val;
            minck=shift;
        end
        
        count=0;
    else
        
        count=count+1;
        
        if count>consecutive
            flag=false;
        end
        
    end
    
    if shift==1 || shift==L
        break;
    end
    
    shift=shift+k;
    ref_val = val;
end

minck=min([minck,L]);
minck=max([minck,1]);








