function [gr1,gr2,tr]=search_first_match(seg1,seg2,tr)

MATCH=1;
GAPX=2;
GAPY=3;

gr1=[];
gr2=[];

c_s1=1;
c_s2=1;
i_tr=1;
while (i_tr<=length(tr)) && ...
        (c_s1<=size(seg1,2)) && ...
        (c_s2<=size(seg2,2)) && ...
        (tr(i_tr) ~= MATCH)
    
    T=tr(i_tr);
    %     switch(T)
    %         case MATCH
    %             % should be never the case
    %             break
    %         case GAPX
    %             gr1=[gr1,seg1(:,c_s1)];
    %             gr2=[gr2,gapsL];
    %             c_s1=c_s1+1;
    %         case GAPY
    %             gr1=[gr1,gapsR];
    %             gr2=[gr2,seg2(:,c_s2)];
    %             c_s2=c_s2+1;
    %     end
    
    gr1=[gr1,seg1(:,c_s1)];
    gr2=[gr2,seg1(:,c_s2)];
    
    c_s1=c_s1+1;
    c_s2=c_s2+1;
    
    i_tr=i_tr+1;
end

tr=tr(i_tr:end);
