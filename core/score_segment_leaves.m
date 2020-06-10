function [lk_v]=score_segment_leaves(node,shift_seq1,shift_seq2,params,P)

Pi=params.Pi;
map=params.map;

seqs_len=size(shift_seq1,2);

lk_v=zeros(1,seqs_len);
for c=1:seqs_len
    % pad char -> skip the column
    if (isKey(params.map,shift_seq1(c))) && (isKey(params.map,shift_seq2(c)))
        col_i=params.map(shift_seq1(c));
        col_j=params.map(shift_seq2(c));
        
        if all_gaps(shift_seq1(c))
            lk_L=rec_compute_lk(node.Left,Pi,map);
        else
            lk_L=0;
        end
        
        if all_gaps(shift_seq2(c))
            lk_R=rec_compute_lk(node.Right,Pi,map);
        else
            lk_R=0;
        end
        
        lk_v(c)=log(node.iota*node.beta*P(col_i,col_j) + lk_L + lk_R);
        
        % iota, beta are local
        % P is sum(Pi*fv0)
        %lk_v(c)=log(node.iota)+log(node.beta)+log(P(col_i,col_j));
    else
        error('WARNING: score_segment_leaves: found PAD char')
    end
end