function [MSA,tot_num_cells]=noFFT_align(node,params)
%%
sequence_1=char(node.Left.sequence);
sequence_2=char(node.Right.sequence);
%%
l1=size(sequence_1,2);
l2=size(sequence_2,2);
%% Sequence padding
seq1=padd_seq_with_value(sequence_1,l2,'right',' ');
seq2=padd_seq_with_value(sequence_2,l1,'left',' ');
%%
coords=[1,l1,l1+1,l1+l2];
%% Align homologous regions
[traceback_cell,segments_cell,LK,tot_num_cells]=align_homologous_segments2(node,coords,seq1,seq2,params);
gappy_traceback_cell_first{1}.tr=[];
gappy_traceback_cell_intermediate{1}.tr=[];
gappy_traceback_cell_last{1}.tr=[];
%% Merge all tracebacks
traceback_final=merge_tracebacks(traceback_cell,gappy_traceback_cell_first,gappy_traceback_cell_intermediate,gappy_traceback_cell_last);
%% Build MSA
MSA=build_MSA(traceback_final,sequence_1,sequence_2);
%% Memory management

%clearvars -except MSA

