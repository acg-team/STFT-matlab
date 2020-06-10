function log_thr=compute_threshold_match(node,P,params)

extended_alphabet_size=params.extended_alphabet_size;

Pmatch=node.iota*node.beta*P;

Pmatch=Pmatch(1:end-1,1:end-1);

D=diag(Pmatch);

min_D=min(D);

Pmatch(1:extended_alphabet_size:end)=-inf;

max_out=max(Pmatch(:));

thr=mean([min_D,max_out]);

log_thr=log(thr);




