function tot=DP_num_cells(l1,l2)

h=l1;
w=l2;
d=(h-1)+(w-1)+1;

M=zeros(h,w,d);
X=zeros(h,w,d);
Y=zeros(h,w,d);
%%
M(1,1,1)=1;
X(1,1,1)=1;
Y(1,1,1)=1;

for k=2:d
    for i=1:h
        for j=1:w
            
            if i-1>0 && j-1>0
                if M(i-1,j-1,k-1)>0 || X(i-1,j-1,k-1)>0 || Y(i-1,j-1,k-1)>0
                    M(i,j,k)=1;
                end
            end
            if i-1>0
                if M(i-1,j,k-1)>0 || X(i-1,j,k-1)>0 || Y(i-1,j,k-1)>0
                    X(i,j,k)=1;
                end
            end
            if j-1>0
                if M(i,j-1,k-1)>0 || X(i,j-1,k-1)>0 || Y(i,j-1,k-1)>0
                    Y(i,j,k)=1;
                end
            end
        end
    end
end
%%
m1=sum(M(:));
x1=sum(X(:));
y1=sum(Y(:));
tot=sum(m1(:)+x1(:)+y1(:));
