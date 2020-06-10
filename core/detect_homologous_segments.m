function [starts,ends]=detect_homologous_segments(mov_average_lk,thr,min_segment_length)

segments=mov_average_lk>thr;

%--------------------------------
% "close" the homologous block
segments=[0,segments,0];
%--------------------------------

segments_start_end=abs(segments(2:end)-segments(1:end-1));

indeces=1:length(segments_start_end);
segments_start_end_idx=indeces(segments_start_end==1);

segments_length=segments_start_end_idx(2:2:end)-segments_start_end_idx(1:2:end);

bool_length=segments_length>min_segment_length;

bool_length_dyadic_upsample=[bool_length,bool_length];
bool_length_dyadic_upsample(1:2:end)=bool_length;
bool_length_dyadic_upsample(2:2:end)=bool_length;

segments_start_end_idx=segments_start_end_idx(bool_length_dyadic_upsample);

starts=segments_start_end_idx(1:2:end);
ends=segments_start_end_idx(2:2:end)-1;

