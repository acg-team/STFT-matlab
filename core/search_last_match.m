function [gl1,gl2,tr]=search_last_match(seg1,seg2,tr)

MATCH=1;

gl1=[];
gl2=[];

c_s1=size(seg1,2);
c_s2=size(seg2,2);
i_tr=length(tr);
while i_tr>1 && c_s1>1 && c_s2>1 && tr(i_tr)~=MATCH
    T=tr(i_tr);
    switch(T)
        case 1
            % should be never the case
            break
        case 2
            gl1=[seg1(:,c_s1),gl1];
            c_s1=c_s1-1;
        case 3
            gl2=[seg2(:,c_s2),gl2];
            c_s2=c_s2-1;
    end
    i_tr=i_tr-1;
end

tr=tr(1:i_tr);

