function lk=filter_homologous_lk_blocks(H1,H2,S,lk_c1,lk_c2)

%display('filter_homologous_lk_blocks')

%if size(H,1)==size(S,1)
if size(S,1)==2
    
    lk=cell(2,1);
    
%     if H(1,1)~=S(1,1)
%         error('ERROR')
%     end
    
    bH=false(1,H1(2)-H1(1)+1);
    bH( (S(1,1):S(1,2))-H1(1)+1 )=true;
    lk{1}=lk_c1(bH);
    
    bH=false(1,H2(2)-H2(1)+1);
    bH( (S(2,1):S(2,2))-H2(1)+1 )=true;
    lk{2}=lk_c2(bH);
    
else
    
    lk=cell(1,1);
    
    idx=min([H1(1),H2(1)]):max([H1(2),H2(2)]);
    lkH1=-inf+0*idx;
    lkH2=-inf+0*idx;
    lkH1( (H1(1):H1(2))-idx(1)+1 )=lk_c1;
    lkH2( (H2(1):H2(2))-idx(1)+1 )=lk_c2;
    
    lk{1}=max([lkH1;lkH2],[],1);
    
end


%lk

