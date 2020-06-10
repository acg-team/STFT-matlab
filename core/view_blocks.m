function view_blocks(ppp,clr)

figure
hold on
for i=1:size(ppp,1)
    plot([ppp(i,3) ppp(i,4)+1],[ppp(i,2)+1 ppp(i,2)+1],'o--','Color',clr)
    plot([ppp(i,4)+1 ppp(i,4)+1],[ppp(i,2)+1 ppp(i,1)],'o--','Color',clr)
    plot([ppp(i,3) ppp(i,3)],[ppp(i,2)+1 ppp(i,1)],'o--','Color',clr)
    plot([ppp(i,3) ppp(i,4)+1],[ppp(i,1) ppp(i,1)],'o--','Color',clr)
    text((ppp(i,3)+ppp(i,4)+1)/2,(ppp(i,2)+1+ppp(i,1))/2,num2str(i),'Color',clr)
end
grid minor
axis ij
axis equal
daspect([1 1 1])