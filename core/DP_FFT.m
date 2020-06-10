function [node,tot_num_cells]=DP_FFT(node,params)
%% DISPLAY
clear FFT_align;
runMsg=strcat('Running DP from node:',node.name,'(',node.Left.name,';',node.Right.name,')');
display(runMsg)

if params.useFFT || params.useSTFT
    if params.useSTFT
        % STFT ALIGN
        [node.sequence,tot_num_cells]=STFT_align(node,params);
    else
        % FFT ALIGN
        [node.sequence,tot_num_cells]=FFT_align(node,params);
    end
else
    % ALIGN W/O FFT
    [node.sequence,tot_num_cells]=noFFT_align(node,params);
end
%% DISPLAY

runMsg=strcat('MSA at node:',node.name);
display(runMsg)
MSA=node.sequence


