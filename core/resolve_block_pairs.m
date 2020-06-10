function [f,flag_all_resolved]=resolve_block_pairs(pairs,flag_all_resolved)



% for i=1:length(pairs)
%     CC=[];
%     for j=1:length(pairs{i})
%      CC=[CC;pairs{i}{j}.blocks];
%     end
%     %m = max(CC(:));
%     m=120;
%     I = zeros(m+1,m+1);
%     figure
%     subplot(1,2,1)
%     plot_blocks(CC,I)
%     colormap(lines(6))
% end


%%
N=length(pairs);

if N>1
    
    f=cell(size(pairs,1),1);
    
    for i=1:length(pairs)-1
        
        %[pair_out,flag]=solve_pairs(pairs{i});
        [pair_out,flag]=solve_pairs_v2(pairs{i});
        
%         f{i}.path=pair_out.path;
%         f{i}.lk=pair_out.lk;
%         f{i}.blocks=pair_out.blocks;

        f=update_this_pair(f,i,N,pair_out);
        
        %pairs{i+1}=update_next_pair(pair_out,pairs{i+1});
        pairs{i+1}=update_next_pair_v2(pair_out,pairs{i+1});
       
        flag_all_resolved=flag_all_resolved & flag;
        
    end
    
    %[pair_out,flag]=solve_pairs(pairs{end});
    [pair_out,flag]=solve_pairs_v2(pairs{end});
    
    f=update_this_pair(f,N,N,pair_out);
    
%     [f_end,f_prev,flag]=update_last_pair(pair_out,f{end-1},flag);
%     
%     if isempty(f_end)
%         f{end-1} = f_prev;
%         f=f(1:N-1);
%     else
%         f{end-1} = f_prev;
%         f{end} = f_end;
%     end
    
    flag_all_resolved=flag_all_resolved & flag;
    
else
    
    f=cell(1,1);
    
    %[pair_out,flag]=solve_pairs(pairs{1});
    [pair_out,flag]=solve_pairs_v2(pairs{1});
    
%     f{1}.path=pair_out.path;
%     f{1}.lk=pair_out.lk;
%     f{1}.blocks=pair_out.blocks;
    
    f=update_this_pair(f,1,N,pair_out);

    flag_all_resolved=flag_all_resolved & flag;
    
end

