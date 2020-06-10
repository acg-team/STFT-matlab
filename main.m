clc
clear all
close all
format long
%%
addpath('./core/')
%%
seed=randseed;
rng(seed);
%%
filename_in='sim-0_MSA.fasta';
filename_tree='sim_0.newick';
filename_out='msa_0.fasta';
%% Read fasta
fasta=fastaread(filename_in);
%% Model parameters
params.lambda=13.142118;
params.mu=0.064462;
%% Null hypothesis params
params.alpha=0.05;
%%
params.consMatch = 4;
%%
params.useFFT = false;
params.useSTFT = true;
%%
params.FIR = 'welch';
params.sizeFIR = 64;
params.delta = 4;
params.numRefinement = 2;
params.pval = 0.0001;
%%
params.threshold=0.7;
%% Homologous detection parameters
params.moving_average_window_size=5;
params.min_segment_length=10;
%% Noise estimation parameters
params.n_iterations=20;
%% Stochastic backtracking parameters
params.SB=0;
params.num_SB=100;
params.Temperature=10;
%% Alphabet
params.alphabet='AA';
%% Homologous detection approach
params.homologous_approach='grantham'; % {grantham,correlation}
%params.homologous_approach='correlation'; % {grantham,correlation}
%% Compute matrix occupation
params.COMPUTE_NUM_CELLS=0;
%% Load substitution model
if strcmp(params.alphabet,'AA')
    [params.Q,params.Pi]=load_subs_model_WAG(params.mu);
else
    [params.Q,params.Pi]=load_subs_model_JC(params.mu);
end
%% Load tree
%%
[node_list,root]=nwk2tree(filename_tree,params.Q);
nseq = length(fasta);

taxa_name=cell(nseq,1);
for i=1:nseq
    taxa_name{i}=node_list(i).name;
end

map_taxa=containers.Map(taxa_name,1:nseq);
fasta=reorder_fasta(fasta,map_taxa);

for i=1:length(node_list)
    if node_list(i).is_leaf
        idx=map_taxa(node_list(i).name);
        node_list(i).sequence=fasta(idx).Sequence;
    end
end
%%
node_list=runDPonTree(node_list,root,params);
root=node_list(end);
%% Write MSA
MSA=root.sequence;
header=root.sequence_name;
MSA_fasta=[];
for k=1:size(MSA,1)
    MSA_fasta(k).Header=header{k};
    MSA_fasta(k).Sequence=MSA(k,:);
end
fastawrite(filename_out,MSA_fasta);
