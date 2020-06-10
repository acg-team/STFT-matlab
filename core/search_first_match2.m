function [gr1,gr2,tr,seg1,seg2]=search_first_match2(seg1,seg2,tr)

len=length(tr);

MATCH=1;
GAPX=2;
GAPY=3;

gr1=[];
gr2=[];

c_s1=1;
c_s2=1;
i_tr=1;
while i_tr<=len

    if tr(i_tr) == MATCH
        break
    elseif tr(i_tr) == GAPX
        gr1=[gr1,seg1(:,c_s1)];
        c_s1=c_s1+1;
    elseif tr(i_tr) == GAPY
        gr2=[gr2,seg2(:,c_s2)];
        c_s2=c_s2+1;  
    else
        
        tr(i_tr)
        
        error('ERROR: search_first_match2')
    end
    
    i_tr=i_tr+1;
end

tr=tr(i_tr:end);
seg1=seg1(:,c_s1:end);
seg2=seg2(:,c_s2:end);


