function [traceback,LK,tot]=DP_leaves(node,segment1,segment2,params)
%% restart random number generator
% seed=1;
% rng(seed);
rng('default')
%%
MATCH=1;
GAPX=2;
GAPY=3;
STOP=4;
%%
tau=params.tau;
mu=params.mu;
map=params.map;
alpha=node.alpha;
bl2root=node.dist2root;
extended_alphabet_size=params.extended_alphabet_size;
nu=params.nu;
Pi=params.Pi;
%%
iotaVL=node.Left.iota;
betaVL=node.Left.beta;
iotaVR=node.Right.iota;
betaVR=node.Right.beta;
%%
h=size(segment1,2)+1;
w=size(segment2,2)+1;
d=(h-1)+(w-1)+1;
%%
matlab_shift=1;
%%
M=ones(h,w,d)*(-inf);
X=ones(h,w,d)*(-inf);
Y=ones(h,w,d)*(-inf);
TR=zeros(h,w,d);
%%
P=get_probability_matrix(node,params);
%%
FV=zeros(extended_alphabet_size,1);
for k=1:extended_alphabet_size
    fv=zeros(extended_alphabet_size,1);
    fv(k)=1;
    FV(k)=sum(Pi.*fv);
end
%% lk empty column
% lk_empty=iotaV0*(1+(betaV0*(-1+P(end,end))))+...
%     iotaVL*(1+(betaVL*(-1+FV(end))))+...
%     iotaVR*(1+(betaVR*(-1+FV(end))));

if isempty(node.Parent)
    lk_up = 0.0;
else
    zeta = exp(-mu*bl2root);
    iotaUp = bl2root/(tau+1/mu);
    betaUp = (1-exp(-mu*bl2root))/(mu*bl2root);
    
    lk_up = alpha*(1-zeta)+...
        iotaUp*(1-betaUp);
end

lk_empty=alpha*P(end,end)+...
    iotaVL*(1+(betaVL*(-1+FV(end))))+...
    iotaVR*(1+(betaVR*(-1+FV(end))))+lk_up;

log_phi0=nu*(lk_empty-1);

M(0+matlab_shift,0+matlab_shift,0+matlab_shift)=log_phi0;
X(0+matlab_shift,0+matlab_shift,0+matlab_shift)=log_phi0;
Y(0+matlab_shift,0+matlab_shift,0+matlab_shift)=log_phi0;

TR(0+matlab_shift,0+matlab_shift,0+matlab_shift)=STOP;

LK=-inf;
level_max=-inf;
consecutive=0;
max_consecutive=1000;%3;
flag_early_stop=false;
%%
for k=1:d-1
    
    if flag_early_stop==true
        break;
    end
    
    %--------------------------------------------------------------
    % GAPX
    j=0;
    %idx_j=j+matlab_shift;
    for i=1:h-1
        
        col_i=segment1(i+matlab_shift-1);
        idx_i=map(col_i);
        
        if not(isinf(M(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift))) || ...
           not(isinf(X(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift))) || ...
           not(isinf(Y(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift)))
            
            lk_c=alpha*P(idx_i,end)+...
                iotaVL*betaVL*FV(idx_i);
            
            X(i+matlab_shift,j+matlab_shift,k+matlab_shift)=...
                -log(k)+log(nu)+log(lk_c)+...
                max([M(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift),...
                     X(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift),...
                     Y(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift)]);
                 
            TR(i+matlab_shift,j+matlab_shift,k+matlab_shift)=GAPX;
        end
    end
    %--------------------------------------------------------------
    %--------------------------------------------------------------
    % GAPY
    i=0;
    %idx_i=i+matlab_shift;
    for j=1:w-1
        
        col_j=segment2(j+matlab_shift-1);
        idx_j=map(col_j);
        
        if not(isinf(M(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
           not(isinf(X(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
           not(isinf(Y(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)))
            
            lk_c=alpha*P(end,idx_j)+...
                iotaVR*betaVR*FV(idx_j);
            
            Y(i+matlab_shift,j+matlab_shift,k+matlab_shift)=...
                -log(k)+log(nu)+log(lk_c)+...
                max([M(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                     X(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                     Y(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)]);
                 
            TR(i+matlab_shift,j+matlab_shift,k+matlab_shift)=GAPY;     
        end
    end
    %--------------------------------------------------------------
    %--------------------------------------------------------------
    for i=1:h-1
        
        col_i=segment1(i+matlab_shift-1);
        idx_i=map(col_i);
        
        for j=1:w-1
            
            col_j=segment2(j+matlab_shift-1);
            idx_j=map(col_j);
            
            %--------------------------------------------------------------
            % MATCH
            %if i-1>0 && j-1>0
                if not(isinf(M(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
                   not(isinf(X(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
                   not(isinf(Y(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)))
                    
                    lk_c=alpha*P(idx_i,idx_j);
                    
                    M(i+matlab_shift,j+matlab_shift,k+matlab_shift)=...
                        -log(k)+log(nu)+log(lk_c)+...
                        max([M(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                             X(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                             Y(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)]);
                end
            %end
            %--------------------------------------------------------------
            % GAPX
            %if i-1>0
                if not(isinf(M(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift))) || ...
                   not(isinf(X(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift))) || ...
                   not(isinf(Y(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift)))
                    
                    lk_c=alpha*P(idx_i,end)+...
                        iotaVL*betaVL*FV(idx_i);
                    
                    X(i+matlab_shift,j+matlab_shift,k+matlab_shift)=...
                        -log(k)+log(nu)+log(lk_c)+...
                        max([M(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift),...
                             X(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift),...
                             Y(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift)]);
                end
            %end
            %--------------------------------------------------------------
            % GAPY
            %if j-1>0
                if not(isinf(M(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
                   not(isinf(X(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
                   not(isinf(Y(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)))
                    
                    lk_c=alpha*P(end,idx_j)+...
                        iotaVR*betaVR*FV(idx_j);
                    
                    Y(i+matlab_shift,j+matlab_shift,k+matlab_shift)=...
                        -log(k)+log(nu)+log(lk_c)+...
                        max([M(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                             X(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                             Y(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)]);
                end
            %end
            %--------------------------------------------------------------
            if not(isinf(M(i+matlab_shift,j+matlab_shift,k+matlab_shift))) || ...
               not(isinf(X(i+matlab_shift,j+matlab_shift,k+matlab_shift))) || ...
               not(isinf(Y(i+matlab_shift,j+matlab_shift,k+matlab_shift)))
                
                [val,idx]=get_max_of_three(M(i+matlab_shift,j+matlab_shift,k+matlab_shift),...
                                           X(i+matlab_shift,j+matlab_shift,k+matlab_shift),...
                                           Y(i+matlab_shift,j+matlab_shift,k+matlab_shift));
                
                TR(i+matlab_shift,j+matlab_shift,k+matlab_shift)=idx;
                
                if i==h-1 && j==w-1
                    

                    
                    if isinf(val)
                        error('ERROR: DP_MSA, isinf')
                    else
                        if val>LK
                            LK=val;
                            level_max=k+matlab_shift;
                            consecutive=0;
                        else
                            consecutive=consecutive+1;
                        end
                        
                        if consecutive>max_consecutive
                            flag_early_stop=true;
                        end
                    end
                    
                end
                
            end
            %--------------------------------------------------------------
        end
    end
end
%%
% mm=squeeze(M(end,end,:));
% xx=squeeze(X(end,end,:));
% yy=squeeze(Y(end,end,:));
% last_column=[mm,xx,yy];
% last_column=squeeze(last_column);
% save('last_column','last_column')
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
% plot(1:d,mv,'b^')
% plot(1:d,xv,'ro')
% plot(1:d,yv,'gx')
% legend('m','x','y')
% hold off
%%
% [max_M,idx_M]=max(M(end,end,:));
% [max_X,idx_X]=max(X(end,end,:));
% [max_Y,idx_Y]=max(Y(end,end,:));
% level_max=[idx_M,idx_X,idx_Y];
% [LK,idx]=get_max_of_three(max_M,max_X,max_Y);
% k=level_max(idx);

%display('DP_leaves')
%k=level_max;
%%
traceback=ones(1,level_max-1)*STOP;
i=h;
j=w;
for k=level_max-1:-1:1
    
    T=TR(i,j,k+matlab_shift);
    
    %[~,T]=max([M(i,j,k),X(i,j,k),Y(i,j,k)]);
    traceback(k)=T;
    
    switch(T)
        case MATCH
            i=i-1;j=j-1;
        case GAPX
            i=i-1;
        case GAPY
            j=j-1;
        otherwise            
            error('DP_leaves: state not recognized')
    end
    %k=k-1;
end


% traceback
% segment1
% segment2


%%
if params.COMPUTE_NUM_CELLS==1
    m1=not(isnan(M(:)));
    x1=not(isnan(X(:)));
    y1=not(isnan(Y(:)));
    tot=sum(m1(:)+x1(:)+y1(:));
else
    tot=0;
end


clearvars -except traceback LK tot

%display('^^^^^^^^^^^^^^^^^^^')

