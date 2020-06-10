function [starts,ends]=filter_blocks_sfft(s1,s2,w12,moving_average_window_size,threshold,min_segment_length)

sb1=s1(:,w12);
sb2=s2(:,w12);

sig = column_gap_content(sb1,sb2);

pad_sig = [sig(1)*ones(1,moving_average_window_size),...
    sig,...
    sig(end)*ones(1,moving_average_window_size)];


mov_average_sig_pad = medfilt1(pad_sig,moving_average_window_size);

mov_average_sig = mov_average_sig_pad(moving_average_window_size+1:end-moving_average_window_size);

[starts,ends]=detect_homologous_segments(mov_average_sig,threshold,min_segment_length);