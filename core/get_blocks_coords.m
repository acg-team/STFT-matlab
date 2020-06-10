function [blocks,ck] = get_blocks_coords(sequence_1,sequence_2,centers,ck_idx,moving_average_window_size,threshold,min_segment_length)

num_k = size(centers,1);

blocks=[];
ck=[];
for k=1:num_k
    
    %----------------------------------------------------------------------
    [s1,s2,a,b]=shift_blocks2(sequence_1,sequence_2,centers(k,:),ck_idx(k));
    %----------------------------------------------------------------------
    [s1;s2]
    %----------------------------------------------------------------------
    sb1=s1(:,a:b);
    sb2=s2(:,a:b);
    
    if ~isempty(sb1) && ~isempty(sb2)
        
        [sb1;sb2]
        
        sig = column_gap_content(sb1,sb2);
        %----------------------------------------------------------------------
        pad_sig = [sig(1)*ones(1,moving_average_window_size),...
            sig,...
            sig(end)*ones(1,moving_average_window_size)];
        
        mov_average_sig_pad = medfilt1(pad_sig,moving_average_window_size);
        
        mov_average_sig = mov_average_sig_pad(moving_average_window_size+1:end-moving_average_window_size);
        
        %----------------------------------------------------------------------
        mov_average_sig = detect_pad(sb1,sb2,mov_average_sig);
        %----------------------------------------------------------------------
        
        %----------------------------------------------------------------------
        [starts,ends]=detect_homologous_segments(mov_average_sig,threshold,min_segment_length);
        %----------------------------------------------------------------------
        if isempty(starts)
            
        else
            
            for i=1:size(starts,2)
                
                a=centers(k,1)+starts(i)-1;
                b=centers(k,2)+(ends(i)-size(mov_average_sig,2));
                
                blocks=[blocks;
                    a , b ];
                
                ck=[ck;
                    ck_idx(k)];
                
            end
            
        end
        %----------------------------------------------------------------------
        
    end
end

