function [traceback,LK,tot]=DP_MSA(node,segment1,segment2,params)

display('DP_MSA')

%% restart random number generator
% seed=2;
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
nu=params.nu;
Pi=params.Pi;
%%
h=size(segment1,2)+1;
w=size(segment2,2)+1;
d=(h-1)+(w-1)+1;

matlab_shift=1;
%%
M=ones(h,w,d)*(-inf);
X=ones(h,w,d)*(-inf);
Y=ones(h,w,d)*(-inf);

TR=zeros(h,w,d);
%%
if isempty(node.Parent)
    lk_up = 0.0;
else
    zeta = exp(-mu*bl2root);
    iotaUp = bl2root/(tau+1/mu);
    betaUp = (1-exp(-mu*bl2root))/(mu*bl2root);

    lk_up = alpha*(1-zeta)+...
            iotaUp*(1-betaUp);
end
%%  
%lk_empty=rec_compute_lk_empty_col(node,Pi,map) + lk_up
%%
[lk_L,fv_L]=rec_compute_lk_empty_col(node.Left,Pi,map);
[lk_R,fv_R]=rec_compute_lk_empty_col(node.Right,Pi,map);
fv=(node.Left.Pr*fv_L) .* (node.Right.Pr*fv_R);
lk_empty=alpha*sum(Pi.*fv) + lk_L + lk_R + lk_up;
%%

log_phi0=nu*(lk_empty-1);

M(0+matlab_shift,0+matlab_shift,0+matlab_shift)=log_phi0;
X(0+matlab_shift,0+matlab_shift,0+matlab_shift)=log_phi0;
Y(0+matlab_shift,0+matlab_shift,0+matlab_shift)=log_phi0;

TR(0+matlab_shift,0+matlab_shift,0+matlab_shift)=STOP;

LK=-inf;
level_max=-inf;
consecutive=0;
max_consecutive=3;
flag_early_stop=false;
%%
col_gap_L=repmat('-',[size(segment1,1),1]);
col_gap_R=repmat('-',[size(segment2,1),1]);

assign_char_to_leaf(node.Left,col_gap_L,1);
assign_char_to_leaf(node.Right,col_gap_R,1);

fv_gap_L=rec_compute_fv_match(node.Left,map);
fv_gap_R=rec_compute_fv_match(node.Right,map);
%%
for k=1:d-1
    
    if flag_early_stop==true
        break;
    end
    
    %--------------------------------------------------------------
    % GAPX
    j=0;
    for i=1:h-1
        
        col_i=segment1(:,i+matlab_shift-1);
        assign_char_to_leaf(node.Left,col_i,1);
        fvL=rec_compute_fv_match(node.Left,map);
        
        if not(isinf(M(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift))) || ...
                not(isinf(X(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift))) || ...
                not(isinf(Y(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift)))
            
            fv0=(node.Left.Pr*fvL) .* (node.Right.Pr*fv_gap_R);
            
            lk_down=rec_compute_lk(node.Left,Pi,map);
            
            %lk_c=node.iota*node.beta*sum(Pi.*fv0)+lk_down;
            lk_c=node.alpha*sum(Pi.*fv0)+lk_down;
            
            X(i+matlab_shift,j+matlab_shift,k+matlab_shift)=...
                -log(k)+log(nu)+log(lk_c)+...
                max([   M(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift),...
                X(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift),...
                Y(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift)]);
            
            TR(i+matlab_shift,j+matlab_shift,k+matlab_shift)=GAPX;
        end
    end
    %--------------------------------------------------------------
    %--------------------------------------------------------------
    % GAPY
    i=0;
    for j=1:w-1
        
        col_j=segment2(:,j+matlab_shift-1);
        assign_char_to_leaf(node.Right,col_j,1);
        fvR=rec_compute_fv_match(node.Right,map);
        
        if not(isinf(M(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
                not(isinf(X(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
                not(isinf(Y(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)))
            
            fv0=(node.Left.Pr*fv_gap_L) .* (node.Right.Pr*fvR);
            
            lk_down=rec_compute_lk(node.Right,Pi,map);
            
            %lk_c=node.iota*node.beta*sum(Pi.*fv0)+lk_down;
            lk_c=node.alpha*sum(Pi.*fv0)+lk_down;
            
            Y(i+matlab_shift,j+matlab_shift,k+matlab_shift)=...
                -log(k)+log(nu)+log(lk_c)+...
                max([   M(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                X(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                Y(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)]);
            
            TR(i+matlab_shift,j+matlab_shift,k+matlab_shift)=GAPY;
        end
    end
    %--------------------------------------------------------------
    %--------------------------------------------------------------
    for i=1:h-1
        
        col_i=segment1(:,i+matlab_shift-1);
        assign_char_to_leaf(node.Left,col_i,1);
        fvL=rec_compute_fv_match(node.Left,map);
        
        for j=1:w-1
            
            col_j=segment2(:,j+matlab_shift-1);
            assign_char_to_leaf(node.Right,col_j,1);
            fvR=rec_compute_fv_match(node.Right,map);
            
            %--------------------------------------------------------------
            % MATCH
            %if i-1>=0 && j-1>=0
                if not(isinf(M(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
                        not(isinf(X(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
                        not(isinf(Y(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)))
                    
                    fv0=(node.Left.Pr*fvL) .* (node.Right.Pr*fvR);
                    
                    %lk_c=node.iota*node.beta*sum(Pi.*fv0);
                    lk_c=node.alpha*sum(Pi.*fv0);
                    
                    M(i+matlab_shift,j+matlab_shift,k+matlab_shift)=...
                        -log(k)+log(nu)+log(lk_c)+...
                        max([   M(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                        X(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                        Y(i-1+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)]);
                end
            %end
            %--------------------------------------------------------------
            % GAPX
            %if i-1>=0
                if not(isinf(M(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift))) || ...
                        not(isinf(X(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift))) || ...
                        not(isinf(Y(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift)))
                    
                    fv0=(node.Left.Pr*fvL) .* (node.Right.Pr*fv_gap_R);
                    
                    lk_down=rec_compute_lk(node.Left,Pi,map);
                    
                    %lk_c=node.iota*node.beta*sum(Pi.*fv0)+lk_down;
                    lk_c=node.alpha*sum(Pi.*fv0)+lk_down;
                    
                    X(i+matlab_shift,j+matlab_shift,k+matlab_shift)=...
                        -log(k)+log(nu)+log(lk_c)+...
                        max([   M(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift),...
                        X(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift),...
                        Y(i-1+matlab_shift,j+matlab_shift,k-1+matlab_shift)]);
                end
            %end
            %--------------------------------------------------------------
            % GAPY
            %if j-1>=0
                if not(isinf(M(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
                        not(isinf(X(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift))) || ...
                        not(isinf(Y(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)))
                    
                    fv0=(node.Left.Pr*fv_gap_L) .* (node.Right.Pr*fvR);
                    
                    lk_down=rec_compute_lk(node.Right,Pi,map);
                    
                    %lk_c=node.iota*node.beta*sum(Pi.*fv0)+lk_down;
                    lk_c=node.alpha*sum(Pi.*fv0)+lk_down;
                    
                    Y(i+matlab_shift,j+matlab_shift,k+matlab_shift)=...
                        -log(k)+log(nu)+log(lk_c)+...
                        max([   M(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                        X(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift),...
                        Y(i+matlab_shift,j-1+matlab_shift,k-1+matlab_shift)]);
                end
            %end
            %--------------------------------------------------------------
            if not(isinf(M(i+matlab_shift,j+matlab_shift,k+matlab_shift))) || ...
                    not(isinf(X(i+matlab_shift,j+matlab_shift,k+matlab_shift))) || ...
                    not(isinf(Y(i+matlab_shift,j+matlab_shift,k+matlab_shift)))
                
                [val,idx]=get_max_of_three( M(i+matlab_shift,j+matlab_shift,k+matlab_shift),...
                    X(i+matlab_shift,j+matlab_shift,k+matlab_shift),...
                    Y(i+matlab_shift,j+matlab_shift,k+matlab_shift));
                
                TR(i+matlab_shift,j+matlab_shift,k+matlab_shift)=idx;
                
                if i==h-1 && j==w-1
                    
%                     display('entro')
%                     segment1
%                     segment2
%                     val
                    
                    if isinf(val)
                        error('ERROR: DP_MSA, isinf')
                    else
                        
                        %[i,j,k,h,w,d,LK,val,level_max]
                        
                        if val>LK
                            
                            %display('val>LK')
                            
                            LK=val;
                            level_max=k+matlab_shift;
                            
%                             display('level_max')
%                             level_max
                            
                            consecutive=0;
                        else
                            
                            %display('consecutive')
                            
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
% [max_M,idx_M]=max(M(end,end,:));
% [max_X,idx_X]=max(X(end,end,:));
% [max_Y,idx_Y]=max(Y(end,end,:));
% level_max=[idx_M,idx_X,idx_Y];
% [LK,idx]=get_max_of_three(max_M,max_X,max_Y);
% k=level_max(idx);

%display('DP_MSA')

%[h,w]

%k=level_max;

%whos k

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


% display('traceback')
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

% clear M
% clear X
% clear Y
% clear TR
% 
% 
% display('^^^^^^^^^^^^^^^^^^^')



