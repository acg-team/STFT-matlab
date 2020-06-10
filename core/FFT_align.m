function [MSA,tot_num_cells]=FFT_align(node,params)
%%
tot_num_cells=NaN;
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
end
%% Pad
if strcmp(params.alphabet,'AA')
    [v1,p1,c1,v2,p2,c2]=pad_AA(v1,p1,c1,v2,p2,c2,params.homologous_approach);
else
    [piA_1,piC_1,piG_1,piT_1,piE_1,piA_2,piC_2,piG_2,piT_2,piE_2]=pad_DNA(piA_1,piC_1,piG_1,piT_1,piE_1,piA_2,piC_2,piG_2,piT_2,piE_2,params.homologous_approach);
end
%% Noise threshold estimation
if strcmp(params.alphabet,'AA')
    noise_thr=noise_estimation_AA(v1,...
        p1,...
        v2,...
        p2,...
        c1,...
        c2,...
        params.n_iterations,params);
else
    noise_thr=noise_estimation_DNA(piA_1,...
        piC_1,...
        piG_1,...
        piT_1,...
        piE_1,...
        piA_2,...
        piC_2,...
        piG_2,...
        piT_2,...
        piE_2,...
        params.n_iterations,params);
end
%% Compute ck
if strcmp(params.homologous_approach,'correlation')
    if strcmp(params.alphabet,'AA')
        ck=compute_correlation_fft_AA(v1,v2,p1,p2,c1,c2);
    else
        ck=compute_correlation_fft_DNA(piA_1,piA_2,piC_1,piC_2,piG_1,piG_2,piT_1,piT_2,piE_1,piE_2);
    end
elseif strcmp(params.homologous_approach,'grantham')
    if strcmp(params.alphabet,'AA')
        ck=grantham_distance_fft_AA(v1,v2,p1,p2,c1,c2);
    else
        ck=grantham_distance_fft_DNA(piA_1,piA_2,piC_1,piC_2,piG_1,piG_2,piT_1,piT_2,piE_1,piE_2);
    end
end
%%
% lw=2;
% ms=8;
% cm=cbrewer('qual','Paired',12);
% figure('Position',[1,1,1024,512],'PaperOrientation','landscape');
% hold on
% plot(ck,'Color',cm(1,:),'LineWidth',lw,'Marker','o','Markersize',ms)
% plot([0,length(ck)],[noise_thr,noise_thr],'k--','LineWidth',1)
% box on
% grid minor
% set(gca,'fontsize', 20);
%
% ylim([min(ck)*0.9,max(ck)*1.1])
%
% %legend('boxoff')
% axis tight
% hold off
%
% stop()
%% Filter ck
[ck_idx,num_k]=filter_ck(ck,noise_thr,params);
%% Sequence padding
seq1=padd_seq_with_value(sequence_1,l2,'right',' ');
seq2=padd_seq_with_value(sequence_2,l1,'left',' ');
%%
if node.Left.is_leaf && node.Right.is_leaf
    
    coords=[1,l1,l1+1,l1+l2];
    
    % Align homologous regions
    [traceback_cell,~,~,~]=align_homologous_segments2(node,coords,seq1,seq2,params);
    
    gappy_traceback_cell_first{1}.tr=[];
    gappy_traceback_cell_intermediate{1}.tr=[];
    gappy_traceback_cell_last{1}.tr=[];
    
else
    
    mL = max([l1,l2]);
    if sum(ismember(ck_idx,mL))==0
        ck_idx=[mL,ck_idx];
    end
    
    coords=[];
    
    for k=1:num_k
        
        for j=0:1
            
            %--------------------------------------
            if l1>=l2
                lag_k=ck_idx(k)+(j*l1)+1;
            else
                lag_k=ck_idx(k)+l1-(j*l2)+1;
            end
            %--------------------------------------
            
            if lag_k>0
                
                [shift_seq1,shift_seq2,offset]=shift_sequences_lag(seq1,seq2,lag_k,l1,l2);
                
                if isempty(shift_seq1) || isempty(shift_seq2)
                    
                else
                    
                    sig = column_gap_content(shift_seq1,shift_seq2);
                    
                    pad_sig = [sig(1)*ones(1,params.moving_average_window_size),...
                        sig,...
                        sig(end)*ones(1,params.moving_average_window_size)];
                    
                    %mov_average_sig = medfilt1(sig,params.moving_average_window_size);
                    
                    mov_average_sig_pad = medfilt1(pad_sig,params.moving_average_window_size);
                    
                    mov_average_sig = mov_average_sig_pad(params.moving_average_window_size+1:end-params.moving_average_window_size);
                    
                    %--------------------------------------------
                    %                     figure
                    %                     hold on
                    %                     plot(sig,'bo-')
                    %                     plot(mov_average_sig,'r*-')
                    %                     hold off
                    
                    %                     figure
                    %                     hold on
                    %                     plot(sig,'bo-')
                    %                     plot(mov_average_sig_pad,'m*-')
                    %                     hold off
                    %
                    %                     lw=2;
                    %                     ms=8;
                    %                     cm=cbrewer('qual','Paired',12);
                    %                     figure('Position',[1,1,1024,512],'PaperOrientation','landscape');
                    %
                    %                     subplot(2,1,1)
                    %                     hold on
                    %                     plot(sig,'Color',cm(2,:),'LineWidth',lw,'LineStyle','-','Marker','o','Markersize',ms)
                    %                     plot(mov_average_sig,'Color',cm(1,:),'LineWidth',lw,'LineStyle','-','Marker','d','Markersize',ms)
                    %                     plot([0,length(mov_average_sig)],[0.7,0.7],'k--','LineWidth',1)
                    %                     %plot([0,length(mov_average_sig)],[0,0],'k-','LineWidth',1)
                    %                     box on
                    %                     grid minor
                    %                     set(gca,'fontsize', 20);
                    %                     legend('column gap content','mov.average column gap content')
                    %                     legend('boxoff')
                    %                     xlim([0,length(mov_average_sig)])
                    %                     ylim([0,1.3])
                    %                     %axis tight
                    %                     hold off
                    
                    
                    %                     h=double(mov_average_sig>0.7);
                    %                     g=double(mov_average_sig>0.7);
                    %
                    %                     for kk=1:length(h)
                    %                         if h(kk)==0
                    %                             h(kk)=NaN;
                    %                         else
                    %                            g(kk)=NaN;
                    %                         end
                    %                     end
                    
                    %                     subplot(2,1,2)
                    %                     hold on
                    %                     plot(h,'Color',cm(3,:),'Marker','o','Markersize',ms)
                    %                     plot(g,'Color',cm(4,:),'Marker','d','Markersize',ms)
                    %                     box on
                    %                     grid minor
                    %                     set(gca,'fontsize', 20);
                    %                     legend('conserved column','gappy column')
                    %                     legend('boxoff')
                    %                     xlim([0,length(mov_average_sig)])
                    %                     ylim([0,1.3])
                    %                     %axis tight
                    %                     hold off
                    
                    
                    %                     [shift_seq1;shift_seq2]
                    
                    %                     stop()
                    %--------------------------------------------
                    
                    [starts,ends]=detect_homologous_segments(mov_average_sig,params.threshold,params.min_segment_length);
                    
                    %--------------------------------------------
                    % store block
                    for i=1:length(starts)
                        a1=starts(i)+offset;
                        b1=ends(i)+offset;
                        
                        a2=a1+lag_k-1;
                        b2=b1+lag_k-1;
                        
                        coords=[coords;
                            [a1,b1,a2,b2]
                            ];
                    end
                    %--------------------------------------------
                    
                end
                
            end
        end
    end
    
    %     l1
    %     l2
    %     coords
    %     stop()
    
    if isempty(coords)
        coords=[1,l1,l1+1,l1+l2];
    else
        
        % Sort jarray e lk_c
        coords=sort_data_v2(coords,[]);
        
        
        %         display('******')
        %         coords
        %         display('......')
        
        % Resolve overlaps
        if size(coords,1)>1
            coords=remove_shift(coords,l1);
            
            coords=overlap_handler4(coords);
            
            coords=add_shift(coords,l1);
        end
        
    end
    
    
    
    %if size(coords,1)==1
    
    coords=remove_shift(coords,l1);
    
    coords=filter_blocks(coords,l1,l2,params.min_segment_length);
    
    coords=add_shift(coords,l1);
    
    %         if tmp(1)-1 < params.min_segment_length || ...
    %                 l1-tmp(2) < params.min_segment_length || ...
    %                 tmp(3)-1 < params.min_segment_length || ...
    %                 l2-tmp(4) < params.min_segment_length
    %
    %             coords=[1,l1,l1+1,l1+l2];
    %
    %         end
    %end
    
    
    
    %     display('-----')
    %     l1
    %     l2
    %     coords
    %     display('-----')
    
    
    
    %     % Align homologous regions
    %     [traceback_cell,segments_cell,~,~]=align_homologous_segments2(node,coords,seq1,seq2,params);
    %
    %     % Align gappy regions
    %     [gappy_traceback_cell_first,traceback_cell,segments_cell,~,~,~]=align_first_gappy_segment2(node,traceback_cell,segments_cell,coords,seq1,seq2,l1,l2,params);
    %     [gappy_traceback_cell_intermediate,traceback_cell,segments_cell,~,~,~]=align_intermediate_gappy_segment2(node,traceback_cell,segments_cell,coords,seq1,seq2,l1,l2,params);
    %     [gappy_traceback_cell_last,traceback_cell,~,~,~,~]=align_last_gappy_segment2(node,traceback_cell,segments_cell,coords,seq1,seq2,l1,l2,params);
    %
    
    
    
    tot_num_cells=0;
    
    % Align homologous regions
    [traceback_cell,segments_cell,~,num_cells]=align_homologous_segments2(node,coords,seq1,seq2,params);
    
    tot_num_cells = tot_num_cells + num_cells;
    
    % Align gappy regions
    [gappy_traceback_cell_first,traceback_cell,segments_cell,~,num_cells,~]=align_first_gappy_segment2(node,traceback_cell,segments_cell,coords,seq1,seq2,l1,l2,params);
    
    tot_num_cells = tot_num_cells + num_cells;
    
    [gappy_traceback_cell_intermediate,traceback_cell,segments_cell,~,num_cells,~]=align_intermediate_gappy_segment2(node,traceback_cell,segments_cell,coords,seq1,seq2,l1,l2,params);
    
    tot_num_cells = tot_num_cells + num_cells;
    
    [gappy_traceback_cell_last,traceback_cell,~,~,num_cells,~]=align_last_gappy_segment2(node,traceback_cell,segments_cell,coords,seq1,seq2,l1,l2,params);
    
    tot_num_cells = tot_num_cells + num_cells;
    
end
%% Merge all tracebacks
traceback_final=merge_tracebacks(traceback_cell,gappy_traceback_cell_first,gappy_traceback_cell_intermediate,gappy_traceback_cell_last);
%% Build MSA
MSA=build_MSA(traceback_final,sequence_1,sequence_2);
%% Memory management

clearvars -except MSA tot_num_cells

