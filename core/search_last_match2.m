function [gr1,gr2,tr,seg1,seg2]=search_last_match2(seg1,seg2,tr)

len=length(tr);

MATCH=1;
GAPX=2;
GAPY=3;

gr1=[];
gr2=[];

c_s1=size(seg1,2);
c_s2=size(seg2,2);
i_tr=len;
while i_tr>0
    
    if tr(i_tr) == MATCH
        break
    elseif tr(i_tr) == GAPX
        gr1=[seg1(:,c_s1),gr1];
        c_s1=c_s1-1;
    elseif tr(i_tr) == GAPY
        gr2=[seg2(:,c_s2),gr2];
        c_s2=c_s2-1;  
    else
        error('ERROR: search_first_match2')
    end
    
    i_tr=i_tr-1;
end

tr=tr(1:i_tr);
seg1=seg1(:,1:c_s1);
seg2=seg2(:,1:c_s2);
