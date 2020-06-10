function [gappy_s1,gappy_s2]=get_gappy_segments(seq1,seq2,gl1,gr1,gl2,gr2,type,jarray1,jarray2,len,params,l1,l2)


%if strcmp(params.homologous_approach,'correlation')
    
    if strcmp(type,'first')
        a=1;
        b=jarray1(1)-1;
        %
        gappy_s1=[gl1,seq1(:,a:b),gr1];
        
        a=1+l1;
        b=(jarray1(1)-1)+(jarray1(4)-1);
        gappy_s2=[gl2,seq2(:,a:b),gr2];

        
        
%         lag_k=jarray1(4)
%         [a1,b1,a2,b2]=get_bound_segments(lag_k,l1,l2)
%         s1=seq1(:,1:a1-1);
%         s2=seq2(:,l1+1:a2-1);
%         gappy_s1=[gl1,s1,gr1];
%         gappy_s2=[gl2,s2,gr2];

        
    elseif strcmp(type,'intermediate')
        a=jarray1(2)+1;
        b=jarray2(1)-1;
        gappy_s1=[gl1,seq1(:,a:b),gr1];
        
        a=jarray1(2)+jarray1(4);
        b=(jarray2(1)-1)+(jarray2(4)-1);
        gappy_s2=[gl2,seq2(:,a:b),gr2];

%         lag_k1=jarray1(4);
%         lag_k2=jarray2(4);

%         [a11,b11,a21,b21]=get_bound_segments(lag_k1,l1,l2);
%         [a12,b12,a22,b22]=get_bound_segments(lag_k2,l1,l2);
% 
%         b11+1
%         a12-1
%         
%         s1=seq1(:,b11+1:a12-1)
%         s2=seq2(:,b21+1:a22-1)
%         gappy_s1=[gl1,s1,gr1];
%         gappy_s2=[gl2,s2,gr2];

    elseif strcmp(type,'last')
        a=jarray2(2)+1;
        b=l1;
        gappy_s1=[gl1,seq1(:,a:b),gr1];
        
        a=jarray2(2)+jarray2(4);
        b=length(seq2);
        gappy_s2=[gl2,seq2(:,a:b),gr2];
        
        
%         lag_k=jarray2(4);
%         [a1,b1,a2,b2]=get_bound_segments(lag_k,l1,l2);
%         s1=seq1(:,b1+1:l1);
%         s2=seq2(:,b2+1:l1+l2);
%         gappy_s1=[gl1,s1,gr1];
%         gappy_s2=[gl2,s2,gr2];
        
    else
        error('type not recognized')
    end
    
%elseif strcmp(params.homologous_approach,'grantham')
    
%     if strcmp(type,'first')
%         a=1
%         b=jarray1(1)-1
%         s1=seq1(:,a:b);
%         gappy_s1=[gl1,s1,gr1];
%         
%         lag_k=jarray1(4);
%         side=jarray1(5);
%         
%         if side==1
%             a2l=1
%             b2l=jarray1(1)-1+lag_k
%             if a2l>0 && b2l>0 && a2l<=len && b2l<=len
%                 s2=seq2(a2l:b2l);
%             else
%                 s2=[];
%             end
%         else
%             a2r=a-(len-lag_k);
%             b2r=b-(len-lag_k);
%             if a2r>0 && b2r>0 && a2r<=len && b2r<=len
%                 s2=seq2(a2r:b2r);
%             else
%                 s2=[];
%             end
%         end
%         gappy_s2=[gl2,s2,gr2];
%                 
%     elseif strcmp(type,'intermediate')
%         a=jarray1(2)+1;
%         b=jarray2(1)-1;
%         s1=seq1(:,a:b);
%         gappy_s1=[gl1,s1,gr1];
%     elseif strcmp(type,'last')
%         a=jarray2(2)+1;
%         b=l1;
%         s1=seq1(:,a:b);
%         gappy_s1=[gappy_MSA_left_1,s1,gappy_MSA_right_1];
%     else
%         error('type not recognized')
%     end
 
%end

