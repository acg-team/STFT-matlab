function [out_block_i_path,...
    out_block_i_lk,...
    out_block_i_coord,...
    out_block_j_path,...
    out_block_j_lk,...
    out_block_j_coord,...
    flag_all_resolved]=resolve_overlap2(type,...
    a1,b1,a2,b2,c1,d1,c2,d2,...
    in_block_i_path,...
    in_block_i_lk,...
    in_block_i_coord,...
    in_block_j_path,...
    in_block_j_lk,...
    in_block_j_coord)
%%
% switch type
%     case 'normal'
%         S=[a1,b1,a2,b2;c1,d1,c2,d2];
%         choice = 4;
%     case 'overlap'
%         S=overlap_resolve_T_overlap(a1,b1,a2,b2,c1,d1,c2,d2);
%         choice = 0;
%     case 'edge'
%         [S,ch]=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
%         choice = ch;
%     case 'select'
%         [S,ch]=overlap_resolve_T_outside(a1,b1,a2,b2,c1,d1,c2,d2,in_block_i_lk,in_block_j_lk);
%         choice = ch;
%     case 'ambiguous'
%         [S,ch]=overlap_resolve_T_outside(a1,b1,a2,b2,c1,d1,c2,d2,in_block_i_lk,in_block_j_lk);
%         choice = ch;      
%     otherwise
%         [a1,b1,a2,b2,c1,d1,c2,d2]
%         error('ERROR')
% end
%%
switch type
    case 'normal'
        S=resolve_T_NORMAL(a1,b1,a2,b2,c1,d1,c2,d2);
        choice = 4;
    case 'overlap'
        S=resolve_T_OVERLAP(a1,b1,a2,b2,c1,d1,c2,d2);
        choice = 0;
    case 'edge'
        [S,ch]=resolve_T_EDGE(a1,b1,a2,b2,c1,d1,c2,d2);
        choice = ch;
    case 'select'
        [S,ch]=resolve_T_SELECT(a1,b1,a2,b2,c1,d1,c2,d2);
        choice = ch;
    otherwise
        [a1,b1,a2,b2,c1,d1,c2,d2]
        error('ERROR in resolve_overlap2')
end
%%
S=check_is_square(S);
%%
if choice==0
    
    flag_all_resolved=false;
    
    lk=filter_homologous_lk_blocks(in_block_i_coord,...
        in_block_j_coord,...
        S,...
        in_block_i_lk,...
        in_block_j_lk);
    
    out_block_i_path = in_block_i_path;
    out_block_i_lk = lk{1};
    out_block_i_coord = S(1,:);
    
    out_block_j_path = in_block_j_path;
    out_block_j_lk = lk{2};
    out_block_j_coord = S(2,:);
        
elseif choice==1
    
    flag_all_resolved=false;
    
    out_block_i_path = in_block_i_path;
    out_block_i_lk = in_block_i_lk;
    out_block_i_coord = S;
    
    out_block_j_path = [];
    out_block_j_lk = [];
    out_block_j_coord = [];
    
elseif choice==2
    
    flag_all_resolved=false;
    
    out_block_i_path = in_block_j_path;
    out_block_i_lk = in_block_j_lk;
    out_block_i_coord = S;
    
    out_block_j_path = [];
    out_block_j_lk = [];
    out_block_j_coord = [];
        
elseif choice==3
    
    flag_all_resolved=false;
    
    lk=filter_homologous_lk_blocks(in_block_i_coord,...
        in_block_j_coord,...
        S,...
        in_block_i_lk,...
        in_block_j_lk);
    
    out_block_i_path = in_block_i_path;
    out_block_i_lk = lk{1};
    out_block_i_coord = S(1,:);
    
    out_block_j_path = [];
    out_block_j_lk = [];
    out_block_j_coord = [];
    
elseif choice ==4  

    flag_all_resolved=true;
    
    out_block_i_path = in_block_i_path;
    out_block_i_lk = in_block_i_lk;
    out_block_i_coord = in_block_i_coord;
    
    out_block_j_path = in_block_j_path;
    out_block_j_lk = in_block_j_lk;
    out_block_j_coord = in_block_j_coord;

elseif choice==5
    
    flag_all_resolved=true;
    
    out_block_i_path = in_block_j_path;
    out_block_i_lk = in_block_j_lk;
    out_block_i_coord = S;
    
    out_block_j_path = [];
    out_block_j_lk = [];
    out_block_j_coord = [];
   
else
    error('ERROR')
end
