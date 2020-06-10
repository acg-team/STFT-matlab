function [MSA,tot_num_cells]=STFT_align(node,params)
%%
sequence_1=char(node.Left.sequence);
sequence_2=char(node.Right.sequence);
%%
l1=size(sequence_1,2);
l2=size(sequence_2,2);
%%
if strcmp(params.alphabet,'AA')
    v1=get_volume(sequence_1,params.map);
    p1=get_polarity(sequence_1,params.map);
    c1=get_composition(sequence_1,params.map);
    
    v2=get_volume(sequence_2,params.map);
    p2=get_polarity(sequence_2,params.map);
    c2=get_composition(sequence_2,params.map);
else
    [piA_1,piC_1,piG_1,piT_1,piE_1]=get_Pi_nucleotides(sequence_1,params.map);
    [piA_2,piC_2,piG_2,piT_2,piE_2]=get_Pi_nucleotides(sequence_2,params.map);
end
%% Dimensionality reduction
if strcmp(params.alphabet,'AA')
    [v1,v2,p1,p2,c1,c2]=dim_reduce_AA(v1,v2,p1,p2,c1,c2);
else
    [piA_1,piA_2,piC_1,piC_2,piG_1,piG_2,piT_1,piT_2,piE_1,piE_2]=dim_reduce_DNA(piA_1,piA_2,piC_1,piC_2,piG_1,piG_2,piT_1,piT_2,piE_1,piE_2);
end
%% Standardization
if strcmp(params.homologous_approach,'correlation')
    if strcmp(params.alphabet,'AA')
        [v1,v2,p1,p2,c1,c2]=standardize_AA(v1,v2,p1,p2,c1,c2);
    else
        [piA_1,piA_2,piC_1,piC_2,piG_1,piG_2,piT_1,piT_2,piE_1,piE_2]=standardize_DNA(piA_1,piA_2,piC_1,piC_2,piG_1,piG_2,piT_1,piT_2,piE_1,piE_2);
    end
elseif strcmp(params.homologous_approach,'grantham')
    % Not necessary
    
    % yes, with STFT needed
    [v1,v2,p1,p2,c1,c2]=standardize_AA(v1,v2,p1,p2,c1,c2);
    
end
%% Pad
if strcmp(params.alphabet,'AA')
    [v1,p1,c1,v2,p2,c2]=pad_AA(v1,p1,c1,v2,p2,c2,params.homologous_approach);
else
    [piA_1,piC_1,piG_1,piT_1,piE_1,piA_2,piC_2,piG_2,piT_2,piE_2]=pad_DNA(piA_1,piC_1,piG_1,piT_1,piE_1,piA_2,piC_2,piG_2,piT_2,piE_2,params.homologous_approach);
end
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================
%%

L=size(v1,2);

% sizeFIR0=params.sizeFIR;
% F=triang(sizeFIR0);
% w_ori0 = [zeros(1,L),F'];
% w_ori0 = circshift(w_ori0,sizeFIR0/2);
% range0 = 1 : params.delta : L+sizeFIR0;
% scale0 = (1/sum(F));

[w_ori0,scale0,range0]=getSTFTfilter(params.FIR,L,params.sizeFIR,params.delta);
%%
pad_v1_L=v1(randi(size(v1,2),[1,params.sizeFIR]));
pad_v2_L=v2(randi(size(v2,2),[1,params.sizeFIR/2]));
pad_v2_R=v2(randi(size(v2,2),[1,params.sizeFIR/2]));

pad_p1_L=p1(randi(size(p1,2),[1,params.sizeFIR]));
pad_p2_L=p2(randi(size(p2,2),[1,params.sizeFIR/2]));
pad_p2_R=p2(randi(size(p2,2),[1,params.sizeFIR/2]));

pad_c1_L=c1(randi(size(c1,2),[1,params.sizeFIR]));
pad_c2_L=c2(randi(size(c2,2),[1,params.sizeFIR/2]));
pad_c2_R=c2(randi(size(c2,2),[1,params.sizeFIR/2]));

v1p0=[pad_v1_L,v1];
v2p0=[pad_v2_L,v2,pad_v2_R];
p1p0=[pad_p1_L,p1];
p2p0=[pad_p2_L,p2,pad_p2_R];
c1p0=[pad_c1_L,c1];
c2p0=[pad_c2_L,c2,pad_c2_R];
%%
Len0=L+params.sizeFIR;
[Z0,T0,W0]=runSTFT(params.n_iterations,v1p0,v2p0,p1p0,p2p0,c1p0,c2p0,range0,Len0,w_ori0,scale0,params.pval);   
[ck_idx0,cc0]=sfft_blocks(Z0,T0,'>');
%%

% T0
% 
% ck_idx0
% 
% figure
% hold on
% z=Z0(:,ck_idx0(1));
% t=z*0+T0;
% plot(z)
% plot(t)
% hold off

%save('z31','z')
%save('th','t')

% save('z8','z')
% 
% stop()
% 
% figure
% hold on
% z=Z0(:,ck_idx0(2));
% t=z*0+T0;
% plot(z)
% plot(t)
% hold off
% 
% save('z64','z')


% figure
% hold on
% for i=1:size(W0,1)
%     plot(W0(i,:))
%     %stop()
% end
% hold off




%%
cc0=lin_interp_coord(cc0,ck_idx0,range0,L+params.sizeFIR,Z0,T0);
delta0=1;

center_coord_filter0=multiresSTFT3(ck_idx0,...
    cc0,...
    params.sizeFIR,...
    params.FIR,...
    L,...
    v1p0,...
    v2p0,...
    p1p0,...
    p2p0,...
    c1p0,...
    c2p0,...
    delta0,...
    params.numRefinement,...
    T0);

center_coord_filter0=max(1,center_coord_filter0);
center_coord_filter0=min(L,center_coord_filter0);
%%
len=params.sizeFIR/2^(params.numRefinement+1);
center_coord_filter=center_coord_filter0+len;
for i=1:params.numRefinement
    
    center_coord_filter = center_coord_filter + len;
    len=len*2;
end
%%
ss1=padd_seq_with_value(sequence_1,params.sizeFIR,'left',' ');
ss2=padd_seq_with_value(sequence_2,params.sizeFIR/2,'left',' ');
ss2=padd_seq_with_value(ss2,params.sizeFIR/2,'right',' ');

if l1>l2
    ss2=padd_seq_with_value(ss2,l1-l2,'right',' ');
elseif l2>l1
    ss1=padd_seq_with_value(ss1,l2-l1,'right',' ');
end

[coords,ck_idx] = get_blocks_coords(ss1,...
    ss2,...
    center_coord_filter,...
    ck_idx0,...
    params.moving_average_window_size,...
    params.threshold,...
    params.min_segment_length);
%%
if isempty(coords)
    coords=[1,l1,l1+1,l1+l2];
else
    
    Len=L+params.sizeFIR;
    cx = get_cx2(coords,ck_idx,Len);
    
    coords = cx;
    
    % Sort jarray e lk_c
    coords=sort_data_v2(coords,[]);
    
    % Resolve overlaps
    if size(coords,1)>1
        coords=remove_shift2(coords,params.sizeFIR);
        
        coords=overlap_handler4(coords);

        coords=add_shift2(coords,params.sizeFIR);
    end
    
    coords=remove_shift2(coords,params.sizeFIR);
    
    coords=filter_blocks(coords,l1,l2,params.min_segment_length);
    
    coords=add_shift2(coords,params.sizeFIR);
    
    coords=remove_shift2(coords,params.sizeFIR);
    
    coords=add_shift(coords,l1);
    
end
%%
seq1=padd_seq_with_value(sequence_1,l2,'right',' ');
seq2=padd_seq_with_value(sequence_2,l1,'left',' ');
%%
tot_num_cells=0;

% Align homologous regions
warning('indel rates qui!!!!')
params.lambda=18.133052631578948/4
params.mu=0.094936842105263/4
[traceback_cell,segments_cell,~,num_cells]=align_homologous_segments2(node,coords,seq1,seq2,params);

tot_num_cells = tot_num_cells + num_cells;

% Align gappy regions
warning('indel rates qui!!!!')
params.lambda=34.4528*4
params.mu=0.18038*4
[gappy_traceback_cell_first,traceback_cell,segments_cell,~,num_cells,~]=align_first_gappy_segment2(node,traceback_cell,segments_cell,coords,seq1,seq2,l1,l2,params);

tot_num_cells = tot_num_cells + num_cells;

[gappy_traceback_cell_intermediate,traceback_cell,segments_cell,~,num_cells,~]=align_intermediate_gappy_segment2(node,traceback_cell,segments_cell,coords,seq1,seq2,l1,l2,params);

tot_num_cells = tot_num_cells + num_cells;

[gappy_traceback_cell_last,traceback_cell,~,~,num_cells,~]=align_last_gappy_segment2(node,traceback_cell,segments_cell,coords,seq1,seq2,l1,l2,params);

tot_num_cells = tot_num_cells + num_cells;

%% Merge all tracebacks
traceback_final=merge_tracebacks(traceback_cell,gappy_traceback_cell_first,gappy_traceback_cell_intermediate,gappy_traceback_cell_last);
%% Build MSA
MSA=build_MSA(traceback_final,sequence_1,sequence_2)





