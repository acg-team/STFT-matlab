function [piA,piC,piG,piT,piE]=get_Pi_nucleotides(seq,mapDNA)

piA=zeros(size(seq,1),size(seq,2));
piC=zeros(size(seq,1),size(seq,2));
piG=zeros(size(seq,1),size(seq,2));
piT=zeros(size(seq,1),size(seq,2));
piE=zeros(size(seq,1),size(seq,2));

for i=1:size(seq,1)
    for j=1:size(seq,2)
        chIdx=mapDNA(seq(i,j));
        switch(chIdx)
            case 1
                piA(i,j)=1;
            case 2
                piC(i,j)=1;
            case 3
                piG(i,j)=1;
            case 4
                piT(i,j)=1;
            case 5
                piE(i,j)=1;
            otherwise
                error('ERROR in get_Pi_nucleotides')
        end
    end
end
