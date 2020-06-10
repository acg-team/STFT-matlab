function MSA=build_MSA(traceback_final,seq1,seq2)

MATCH=1;
GAPX=2;
GAPY=3;

MSA=[];

[h1,w1]=size(seq1);
[h2,w2]=size(seq2);

idx_s1=w1;
idx_s2=w2;
for k=length(traceback_final):-1:1
    
    T=traceback_final(k);
    switch(T)
        case MATCH
            column=[seq1(:,idx_s1);
                    seq2(:,idx_s2)];
            MSA=[column,MSA];
            idx_s1=idx_s1-1;
            idx_s2=idx_s2-1;
        case GAPX
            gaps=repmat('-',[h2,1]);
            column=[seq1(:,idx_s1);
                    gaps];
            MSA=[column,MSA];
            idx_s1=idx_s1-1;
        case GAPY
            gaps=repmat('-',[h1,1]);
            column=[gaps;
                    seq2(:,idx_s2)];
            MSA=[column,MSA];
            idx_s2=idx_s2-1;
    end
    
end

