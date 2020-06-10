function plot_blocks(H,I)

hold on

[h,w]=size(I);

for k=1:size(H,1)
    a1=H(k,1);
    b1=H(k,2);
    a2=H(k,3);
    b2=H(k,4);
    I(a1:b1,a2:b2)=I(a1:b1,a2:b2)+k;
end

%I

% diag_xu_1=H(:,1);
% diag_xd_1=H(:,2);
% diag_yu_1=H(:,3);
% diag_yd_1=H(:,4);

set(gca,'ydir','reverse');

imagesc(I)
alpha(.5)
for i=0:h
    plot([0+0.5 w+0.5],[i+0.5 i+0.5],'k-')
end
for j=0:w
    plot([j+0.5 j+0.5],[0+0.5 h+0.5],'k-')
end

% for i=1:size(diag_xu_1,1)
%     plot([diag_yu_1(i)+0.5,diag_yd_1(i)+0.5],[diag_xu_1(i)+0.5,diag_xd_1(i)+0.5],'r','LineWidth',2)
% end

xticks(1:1:w)
xtickangle(90)
yticks(1:1:h)
hold off
axis equal
axis tight