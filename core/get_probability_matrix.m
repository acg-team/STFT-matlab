function P=get_probability_matrix(node,params)

PrL=node.Left.Pr;
PrR=node.Right.Pr;

Pi=params.Pi;

extended_alphabet_size=params.extended_alphabet_size;

fvL=zeros(extended_alphabet_size,1);
fvR=zeros(extended_alphabet_size,1);

P=zeros(extended_alphabet_size,extended_alphabet_size);
for i=1:extended_alphabet_size
    
    fvL = indicatorFun(fvL,i);
    
    for j=1:extended_alphabet_size
        
        fvR = indicatorFun(fvR,j);
        
        fv0=(PrL*fvL) .* (PrR*fvR);
        
        P(i,j)=sum(Pi.*fv0);
    end
end
%%
% figure('rend','painters','pos',[10 10 900 600])
% bar3(P)
% axis tight
% %xticks(1:20)
% %xticklabels(AA)
% %yticks(1:20)
% %yticklabels(AA)
% set(findall(gcf,'-property','FontSize'),'FontSize',18)
% rotate3d on
% view(3)
