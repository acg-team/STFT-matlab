function S=resolve_overlap(type,a1,b1,a2,b2,c1,d1,c2,d2,lk_c)

switch type
    case 'normal'
        S=[a1,b1,a2,b2;
            c1,d1,c2,d2];
    case 'overlapI'
        S=overlap_resolve_T_overlap(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'overlapX'
        S=overlap_resolve_T_overlap(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'overlapY'
        S=overlap_resolve_T_overlap(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'identical'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'insideI'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'insideII'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'edgeX'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'edgeY'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'insideXI'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'insideXII'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'insideXIII'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'insideXIV'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'insideYI'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'insideYII'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'insideYIII'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'insideYIV'
        S=overlap_resolve_T_edge(a1,b1,a2,b2,c1,d1,c2,d2);
    case 'selectX'
        S=overlap_resolve_T_outside(a1,b1,a2,b2,c1,d1,c2,d2,lk_c);
    case 'selectY'
        S=overlap_resolve_T_outside(a1,b1,a2,b2,c1,d1,c2,d2,lk_c);
    otherwise
        [a1,b1,a2,b2,c1,d1,c2,d2]
        error('ERROR')
end