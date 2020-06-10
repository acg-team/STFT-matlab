function gappy_traceback_cell_vector=SB_DP_leaves(segment1,segment2,params)

gappy_traceback_cell_vector=cell(params.num_SB,1);
%%
mapAA=params.map;
extended_alphabet_size=params.extended_alphabet_size;
nu=params.nu;
Pi=params.Pi;
bl=params.bl;
iotas=params.iotas;
betas=params.betas;
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

M=ones(h,w,d)*(-inf);
X=ones(h,w,d)*(-inf);
Y=ones(h,w,d)*(-inf);

Mp=ones(h,w,d)*(-inf);
Xp=ones(h,w,d)*(-inf);
Yp=ones(h,w,d)*(-inf);
%%
P=get_probability_matrix(node,params);
%%
FV=zeros(extended_alphabet_size,1);
fv=zeros(extended_alphabet_size,1);
for k=1:extended_alphabet_size
    fv=fv*0;
    fv(k)=1;
    FV(k)=sum(Pi.*fv);
end
%%
lk_empty=iotaV0*(1+(betaV0*(-1+P(end,end))))+...
    iotaV1*(1+(betaV1*(-1+FV(end))))+...
    iotaV2*(1+(betaV2*(-1+FV(end))));

p0=nu*(lk_empty-1);

M(1,1,1)=p0;
X(1,1,1)=p0;
Y(1,1,1)=p0;

Mp(1,1,1)=p0;
Xp(1,1,1)=p0;
Yp(1,1,1)=p0;

for k=2:d
    for i=1:h
        
        col_i=segment1(i);
        idx_i=mapAA(col_i);
        
        for j=1:w
            
            col_j=segment2(j);
            idx_j=mapAA(col_j);
            
            if i-1>0 && j-1>0
                if not(isinf(M(i-1,j-1,k-1))) || not(isinf(X(i-1,j-1,k-1))) || not(isinf(Y(i-1,j-1,k-1)))
                    lk_c=log(iotaV0*betaV0*P(idx_i,idx_j));
                    lk=-log(k-1)+log(nu)+lk_c;
                    l1=add_lns_2(M(i-1,j-1,k-1),X(i-1,j-1,k-1));
                    l2=add_lns_2(l1,Y(i-1,j-1,k-1));
                    M(i,j,k)=add_lns_2(lk,l2);
                    Mp(i,j,k)=lk_c;
                end
            end
            if i-1>0
                if not(isinf(M(i-1,j,k-1))) || not(isinf(X(i-1,j,k-1))) || not(isinf(Y(i-1,j,k-1)))
                    lk_c=log(iotaV0*betaV0*P(idx_i,idx_j)+...
                        iotaV1+betaV1*FV(idx_i));
                    lk=-log(k-1)+log(nu)+lk_c;
                    l1=add_lns_2(M(i-1,j,k-1),X(i-1,j,k-1));
                    l2=add_lns_2(l1,Y(i-1,j,k-1));
                    X(i,j,k)=add_lns_2(lk,l2);
                    Xp(i,j,k)=lk_c;
                end
            end
            if j-1>0
                if not(isinf(M(i,j-1,k-1))) || not(isinf(X(i,j-1,k-1))) || not(isinf(Y(i,j-1,k-1)))
                    lk_c=log(iotaV0*betaV0*P(idx_i,idx_j)+...
                        iotaV2+betaV2*FV(idx_j));
                    lk=-log(k-1)+log(nu)+lk_c;
                    l1=add_lns_2(M(i,j-1,k-1),X(i,j-1,k-1));
                    l2=add_lns_2(l1,Y(i,j-1,k-1));
                    Y(i,j,k)=add_lns_2(lk,l2);
                    Yp(i,j,k)=lk_c;
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
for sb=1:params.params.num_SB
    
    Temperature=params.Temperature;
    
    [max_M,idx_M]=max(M(end,end,:));
    [max_X,idx_X]=max(X(end,end,:));
    [max_Y,idx_Y]=max(Y(end,end,:));
    level_max=[idx_M,idx_X,idx_Y];
    
    [LK,T]=max([max_M,max_X,max_Y]);
    
    i=int32(h);
    j=int32(w);
    k=int32(level_max(T));
    
    log_Zm=M(i,j,k);
    log_Zx=X(i,j,k);
    log_Zy=Y(i,j,k);
    
    if isinf(log_Zm) && isinf(log_Zx) && isinf(log_Zy)
        error('ERROR 1: Zm, Zx and Zy are inf')
    end
    
    log_Zmx=add_lns_2(log_Zm,log_Zx);
    log_Z=add_lns_2(log_Zmx,log_Zy);
    
    if isinf(log_Z)
        error('ERROR 2 Z: is inf')
    end
    
    if isinf(log_Zm)
        pm=0;
        pmn=0;
    else
        log_pm=log_Zm-log_Z;
        pm=exp(log_pm);
        pmn=exp(-(1-pm)/Temperature);
    end
    
    if isinf(log_Zx)
        px=0;
        pxn=0;
    else
        log_px=log_Zx-log_Z;
        px=exp(log_px);
        pxn=exp(-(1-px)/Temperature);
    end
    
    if isinf(log_Zy)
        py=0;
        pyn=0;
    else
        log_py=log_Zy-log_Z;
        py=exp(log_py);
        pyn=exp(-(1-py)/Temperature);
    end
    
    %------------------------------
    z=pmn+pxn+pyn;
    pm=pmn./z;
    px=pxn./z;
    py=pyn./z;
    %------------------------------
    
    traceback=[];
    
    m=1;
    lk=-log(m)+log(nu)+p0;
    while i>1 || j>1 || k>1
        
        r=rand(1);
        
        if r<pm
            log_P=Mp(i,j,k);
            i=i-1;
            j=j-1;
            k=k-1;
            T=1;
        elseif r<(pm+px)
            log_P=Xp(i,j,k);
            i=i-1;
            k=k-1;
            T=2;
        else
            log_P=Yp(i,j,k);
            j=j-1;
            k=k-1;
            T=3;
        end
        
        if isinf(log_P)
            error('ERROR 3: P inf')
        end
        
        
        lk=lk+log_P;
        
        traceback=[T,traceback];
        
        log_Zm=M(i,j,k);
        log_Zx=X(i,j,k);
        log_Zy=Y(i,j,k);
        
        if isinf(log_Zm) && isinf(log_Zx) && isinf(log_Zy)
            error('ERROR 1: Zm, Zx and Zy are inf')
        end
        
        log_Zmx=add_lns_2(log_Zm,log_Zx);
        log_Z=add_lns_2(log_Zmx,log_Zy);
        
        if isinf(log_Z)
            error('ERROR 2 Z: is inf')
        end
        
        if isinf(log_Zm)
            pm=0;
            pmn=0;
        else
            log_pm=log_Zm-log_Z;
            pm=exp(log_pm);
            pmn=exp(-(1-pm)/Temperature);
        end
        
        if isinf(log_Zx)
            px=0;
            pxn=0;
        else
            log_px=log_Zx-log_Z;
            px=exp(log_px);
            pxn=exp(-(1-px)/Temperature);
        end
        
        if isinf(log_Zy)
            py=0;
            pyn=0;
        else
            log_py=log_Zy-log_Z;
            py=exp(log_py);
            pyn=exp(-(1-py)/Temperature);
        end
        
        %------------------------------
        z=pmn+pxn+pyn;
        pm=pmn./z;
        px=pxn./z;
        py=pyn./z;
        
    end
    
    gappy_traceback_cell_vector{sb}.tr=traceback;
    gappy_traceback_cell_vector{sb}.dim=[h,w,d];
end

if params.COMPUTE_NUM_CELLS==1
    m1=not(isnan(M(:)));
    x1=not(isnan(X(:)));
    y1=not(isnan(Y(:)));
    tot=sum(m1(:)+x1(:)+y1(:));
else
    tot=0;
end

