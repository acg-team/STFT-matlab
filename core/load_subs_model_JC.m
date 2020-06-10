function [Q,Pi]=load_subs_model_JC(mu)

Q=[-3/4  1/4  1/4  1/4 0.0
    1/4 -3/4  1/4  1/4 0.0
    1/4  1/4 -3/4  1/4 0.0
    1/4  1/4  1/4 -3/4 0.0
    0.0  0.0  0.0  0.0 0.0];
%%
Pi=zeros(5,1);
for i=1:4
   Q(i,i)=Q(i,i)-mu;
   Q(i,end)=mu; 
   Pi(i)=1/4;
end