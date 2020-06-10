function [traceback,LK,tot]=DP(segment1,segment2,params,COMPUTE_NUM_CELLS)

mapAA=params.map;
extended_alphabet_size=params.extended_alphabet_size;
lambda=params.lambda;
mu=params.mu;
tau=params.tau;
nu=params.nu;
Q=params.Q;
Pi=params.Pi;
bl=params.bl;
iotas=params.iotas;
betas=params.betas;

bv1=bl(1);
bv2=bl(2);
iotaV0=iotas(1);
iotaV1=iotas(2);
iotaV2=iotas(3);
betaV0=betas(1);
betaV1=betas(2);
betaV2=betas(3);
%%
h=length(segment1+1);
w=length(segment2+1);
d=(h-1)+(w-1)+1;
%MIN_VAL = 0;
% M=zeros(h,w,d);
% X=zeros(h,w,d);
% Y=zeros(h,w,d);

% LOG
M=ones(h,w,d)*(-inf);
X=ones(h,w,d)*(-inf);
Y=ones(h,w,d)*(-inf);
%%
fv_gap=zeros(extended_alphabet_size,1);
fv_gap(end)=1;

fv1=fv_gap;
fv2=fv_gap;
fv0=expm(bv1*Q)*fv1.*expm(bv2*Q)*fv2;
lk_empty=iotaV0*(1+(betaV0*(-1+sum(Pi.*fv0))))+...
        iotaV1*(1+(betaV1*(-1+sum(Pi.*fv1))))+...
        iotaV2*(1+(betaV2*(-1+sum(Pi.*fv2))));

p0=nu*(lk_empty-1); %

M(1,1,1)=p0;
X(1,1,1)=p0;
Y(1,1,1)=p0;

fv1=zeros(extended_alphabet_size,1);
fv2=zeros(extended_alphabet_size,1);

for k=2:d
    for i=1:h
        
        col_i=segment1(i);
        fv1=fv1*0;
        fv1(mapAA(col_i))=1;
        
        for j=1:w
            
            col_j=segment2(j);
            fv2=fv2*0;
            fv2(mapAA(col_j))=1;
            
            if i-1>0 && j-1>0
                if not(isinf(M(i-1,j-1,k-1))) || not(isinf(X(i-1,j-1,k-1))) || not(isinf(Y(i-1,j-1,k-1)))
                    
                    fv0=expm(bv1*Q)*fv1.*expm(bv2*Q)*fv2;
                    lk_c=iotaV0*betaV0*sum(Pi.*fv0);
                    
                    M(i,j,k)=-log(k-1)+log(nu)+log(lk_c)+max([M(i-1,j-1,k-1),X(i-1,j-1,k-1),Y(i-1,j-1,k-1)]);
                end
            end
            if i-1>0
                if not(isinf(M(i-1,j,k-1))) || not(isinf(X(i-1,j,k-1))) || not(isinf(Y(i-1,j,k-1)))
                    fv0=expm(bv1*Q)*fv1.*expm(bv2*Q)*fv_gap;
                    lk_c=iotaV0*betaV0*sum(Pi.*fv0)+...
                         iotaV1+betaV1*sum(Pi.*fv1);
                    
                    X(i,j,k)=-log(k-1)+log(nu)+log(lk_c)+max([M(i-1,j,k-1),X(i-1,j,k-1),Y(i-1,j,k-1)]);
                end
            end
            if j-1>0
                if not(isinf(M(i,j-1,k-1))) || not(isinf(X(i,j-1,k-1))) || not(isinf(Y(i,j-1,k-1)))
                    fv0=expm(bv1*Q)*fv_gap.*expm(bv2*Q)*fv2;
                    lk_c=iotaV0*betaV0*sum(Pi.*fv0)+...
                         iotaV2+betaV2*sum(Pi.*fv2);
                    
                    Y(i,j,k)=-log(k-1)+log(nu)+log(lk_c)+max([M(i,j-1,k-1),X(i,j-1,k-1),Y(i,j-1,k-1)]);
                end
            end
        end
    end
end
%%
% figure
% hold on
% mv=M(end,end,:);
% xv=X(end,end,:);
% yv=Y(end,end,:);
% 
% mv=squeeze(mv);
% xv=squeeze(xv);
% yv=squeeze(yv);
% 
% plot(mv,'b^')
% plot(xv,'ro')
% plot(yv,'gx')
% legend('m','x','y')
% hold off
%%
[max_M,idx_M]=max(M(end,end,:));
[max_X,idx_X]=max(X(end,end,:));
[max_Y,idx_Y]=max(Y(end,end,:));
level_max=[idx_M,idx_X,idx_Y];

[LK,idx]=max([max_M,max_X,max_Y]);
traceback=[];
i=h;
j=w;
k=level_max(idx);
while i>=1 || j>=1
    [~,T]=max([M(i,j,k),X(i,j,k),Y(i,j,k)]);
    
    traceback=[T,traceback];
    
    switch(T)
        case 1
            i=i-1;j=j-1;
        case 2
            i=i-1;
        case 3
            j=j-1;
    end
    k=k-1;
end

if COMPUTE_NUM_CELLS
    m1=not(isnan(M(:)));
    x1=not(isnan(X(:)));
    y1=not(isnan(Y(:)));
    tot=sum(m1(:)+x1(:)+y1(:));
else
    tot=0;
end
