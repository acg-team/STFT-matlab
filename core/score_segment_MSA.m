function [lk_v]=score_segment_MSA(node,shift_seq1,shift_seq2,params)

if size(shift_seq1,2) ~= size(shift_seq2,2)
    error('ERROR: score_segment_MSA: size not equals')
end

Pi=params.Pi;
map=params.map;

seqs_len=size(shift_seq1,2);
lk_v=zeros(1,seqs_len);
for c=1:seqs_len
    if not(column_contains_pad(shift_seq1(:,c),params.map)) && not(column_contains_pad(shift_seq2(:,c),params.map))
        assign_char_to_leaf(node.Left,shift_seq1(:,c),1);
        assign_char_to_leaf(node.Right,shift_seq2(:,c),1);
        
        fvL=rec_compute_fv_match(node,params.map);
        fvR=rec_compute_fv_match(node,params.map);
        
        fv0=(node.Left.Pr*fvL) .* (node.Right.Pr*fvR);
        
        if all_gaps(shift_seq1(:,c))
            lk_L=rec_compute_lk(node.Left,Pi,map);
        else
            lk_L=0;
        end
        
        if all_gaps(shift_seq2(:,c))
            lk_R=rec_compute_lk(node.Right,Pi,map);
        else
            lk_R=0;
        end
        
        lk_v(c)=log(node.iota*node.beta*sum(params.Pi.*fv0) + lk_L + lk_R);
        
        %lk_v(c)=log(node.iota)+log(node.beta)+log(sum(params.Pi.*fv0));
    else
        error('WARNING: score_segment_MSA: found PAD char')
    end
end



