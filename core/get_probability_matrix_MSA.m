function P=get_probability_matrix_MSA(node,params)

Pr1=node.Left.Pr;
Pr2=node.Right.Pr;

Pi=params.Pi;
extended_alphabet_size=params.extended_alphabet_size;

P=zeros(extended_alphabet_size,extended_alphabet_size);
for i=1:extended_alphabet_size    
    
    fv1=rec_compute_fv(node,i);
    
    for j=1:extended_alphabet_size
        fv2=rec_compute_fv(node,j);
        
        fv0=Pr1*fv1.*Pr2*fv2;
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