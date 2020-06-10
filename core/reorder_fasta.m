function msa_s=reorder_fasta(msa,map_taxa)

msa_s=msa; % for memory allocation

for i=1:length(msa)
   idx=map_taxa(msa(i).Header);
   msa_s(idx).Header=msa(i).Header;
   msa_s(idx).Sequence=msa(i).Sequence;
end
