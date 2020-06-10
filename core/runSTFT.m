function [Z,th,W]=runSTFT(N,v1,v2,p1,p2,c1,c2,range,L,w_ori,scale,p)

%% noise threshold inference
TH=zeros(1,N*length(range)*L);

a=1;
b=length(range)*L;
for j=1:N
    
    idx_perm=randperm(size(v2,2));
    
    v2p=v2(idx_perm);
    p2p=p2(idx_perm);
    c2p=c2(idx_perm);

    Zth = perform_STFT(v1,v2p,p1,p2p,c1,c2p,L,w_ori,scale,range);
    
    TH(a:b)=Zth(1:size(Zth,1)*size(Zth,2));
    
    a=b+1;
    b=b+length(range)*L;
end

THS=sort(TH,'desc');
%THS=sort(TH,'asc');
th = THS(floor(p*length(THS)));
%% STFT
[Z,W]=perform_STFT(v1,v2,p1,p2,c1,c2,L,w_ori,scale,range);
%%
%%
% figure
% hold on
% %W0(:,20:120)=NaN;
% [X,Y]=meshgrid(1:size(Z,2),1:size(Z,1));
% s1=surf(X,Y,Z,'FaceAlpha',0.9);
% %s2=surf(X,Y,Z*0+th,'FaceColor','black','EdgeColor','none','FaceAlpha',0.5);
% axis tight
% 
% cmap = cbrewer('seq','RdPu',100);
% cmap = cbrewer('seq','Blues',100);
% %cmap = cbrewer('div','PRGn',100);
% %cmap=cbrewer('qual','Paired',10);
% colormap(cmap)
% 
% %set(gca, 'Zdir', 'reverse')
% set(gca, 'Ydir', 'reverse')
% 
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% 
% view(3)
% rotate3d on
% 
% view(48,25)
% 
% box on
% hold off
% 
% ax = gca;
% ax.BoxStyle = 'full';
% grid on
% 
% 
% 
% stop()
%%
% figure
% hold on
% %W0(:,20:120)=NaN;
% [X,Y]=meshgrid(1:size(Z,2),1:size(Z,1));
% s1=surf(X,Y,W,'FaceAlpha',0.9);
% %s2=surf(X,Y,Z*0+th,'FaceColor','black','EdgeColor','none','FaceAlpha',0.5);
% axis tight
% 
% cmap = cbrewer('seq','RdPu',100);
% cmap = cbrewer('seq','Blues',100);
% %cmap = cbrewer('div','PiYG',100);
% %cmap=cbrewer('qual','Paired',10);
% colormap(cmap)
% 
% %set(gca, 'Zdir', 'reverse')
% set(gca, 'Ydir', 'reverse')
% 
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% 
% view(3)
% rotate3d on
% 
% view(48,25)
% 
% box on
% hold off
% 
% ax = gca;
% ax.BoxStyle = 'full';
% grid on
% 
% range

%save('W','W')



