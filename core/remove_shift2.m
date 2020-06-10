function coords=remove_shift2(coords,shift)

coords(:,1)=coords(:,1)-shift;
coords(:,2)=coords(:,2)-shift;
coords(:,3)=coords(:,3)-shift/2;
coords(:,4)=coords(:,4)-shift/2;