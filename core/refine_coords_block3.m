function [cw1,cw2] = refine_coords_block3(...
    cw1,...
    cw2,...
    ck,...
    L,...
    v1,...
    v2,...
    p1,...
    p2,...
    c1,...
    c2,...
    sizeH,...
    w_ori,...
    scale,...
    T)


%w_ori=circshift(w_ori,sizeH/2); %now the center of w_ori is at 0
%%
w=circshift(w_ori,cw1);
% vz2=w(1:L) .* v2;
% pz2=w(1:L) .* p2;
% cz2=w(1:L) .* c2;
vz2 = w .* v2;
pz2 = w .* p2;
cz2 = w .* c2;
val1= sum( (scale)* ( v1 .* circshift(vz2,-ck) +...
    p1 .* circshift(pz2,-ck)+...
    c1 .* circshift(cz2,-ck) ) );
% vy=ifft( fft(fliplr(v1)) .* fft(vz2) );
% py=ifft( fft(fliplr(p1)) .* fft(pz2) );
% cy=ifft( fft(fliplr(c1)) .* fft(cz2) );
% Z1=(scale)*(vy+py+cy);
% val1=Z1(ck);
%%
w=circshift(w_ori,cw2);
% vz2=w(1:L) .* v2;
% pz2=w(1:L) .* p2;
% cz2=w(1:L) .* c2;
vz2 = w .* v2;
pz2 = w .* p2;
cz2 = w .* c2;
% vy=ifft( fft(fliplr(v1)) .* fft(vz2) );
% py=ifft( fft(fliplr(p1)) .* fft(pz2) );
% cy=ifft( fft(fliplr(c1)) .* fft(cz2) );
% Z2=(scale)*(vy+py+cy);
% val2=Z2(ck);
val2=sum( (scale)* ( v1 .* circshift(vz2,-ck) +...
    p1 .* circshift(pz2,-ck)+...
    c1 .* circshift(cz2,-ck) ) );
%%

%figure
%hold on

flag1=false;
flag2=false;
while (cw2>=cw1)
    
    if val1>=T
        flag1=true;
    else
        cw1=cw1+1;
        w=circshift(w_ori,cw1);
        
        
        %plot(w)

        
        
        %         vz2=w(1:L) .* v2;
        %         pz2=w(1:L) .* p2;
        %         cz2=w(1:L) .* c2;
        vz2 = w .* v2;
        pz2 = w .* p2;
        cz2 = w .* c2;
        %         vy=ifft( fft(fliplr(v1)) .* fft(vz2) );
        %         py=ifft( fft(fliplr(p1)) .* fft(pz2) );
        %         cy=ifft( fft(fliplr(c1)) .* fft(cz2) );
        %         Z1=(scale)*(vy+py+cy);
        %         val1=Z1(ck);
        
        val1 = sum( (scale)* ( v1 .* circshift(vz2,-ck) +...
            p1 .* circshift(pz2,-ck) +...
            c1 .* circshift(cz2,-ck) ) );
        
    end
    
    if val2>=T
        flag2=true;
    else
        cw2=cw2-1;
        w=circshift(w_ori,cw2);
        %         vz2=w(1:L) .* v2;
        %         pz2=w(1:L) .* p2;
        %         cz2=w(1:L) .* c2;
        vz2 = w .* v2;
        pz2 = w .* p2;
        cz2 = w .* c2;
        %         vy=ifft( fft(fliplr(v1)) .* fft(vz2) );
        %         py=ifft( fft(fliplr(p1)) .* fft(pz2) );
        %         cy=ifft( fft(fliplr(c1)) .* fft(cz2) );
        %         Z2=(scale)*(vy+py+cy);
        %         val2=Z2(ck);
        
        val2 = sum( (scale)* ( v1 .* circshift(vz2,-ck) +...
            p1 .* circshift(pz2,-ck) +...
            c1 .* circshift(cz2,-ck) ) );
    end
    
    if (flag1 && flag2)
        break;
    end
    
end



%hold off



