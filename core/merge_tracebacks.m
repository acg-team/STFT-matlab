function traceback_final=merge_tracebacks(traceback_cell,gappy_traceback_cell_first,gappy_traceback_cell_intermediate,gappy_traceback_cell_last)

display('In merge_tracebacks:')

display('traceback_cell:')
for k=1:size(traceback_cell,1)
    traceback_cell{k}
end
display('gappy_traceback_cell_first:')
for k=1:size(gappy_traceback_cell_first,1)
    gappy_traceback_cell_first{k}
end
display('gappy_traceback_cell_intermediate:')
for k=1:size(gappy_traceback_cell_intermediate,1)
    gappy_traceback_cell_intermediate{k}
end
display('gappy_traceback_cell_last:')
for k=1:size(gappy_traceback_cell_last,1)
    gappy_traceback_cell_last{k}
end
%%
if isempty(traceback_cell)
    error('ERROR: merge_tracebacks : traceback_cell empty')
end

% Merge gappy tracebacks
if size(traceback_cell,1)==1
    
    if size(gappy_traceback_cell_intermediate,1)>1
        error('ERROR: merge_tracebacks : gappy_traceback_cell_intermediate wrong size')
    end
    
    if not(isempty(gappy_traceback_cell_intermediate{1}.tr))
        error('ERROR: merge_tracebacks : gappy_traceback_cell_intermediate not empty')
    end
    
    % only first and last
    gappy_traceback_cell=[gappy_traceback_cell_first;gappy_traceback_cell_last];
    
else
    gappy_traceback_cell=[gappy_traceback_cell_first;gappy_traceback_cell_intermediate;gappy_traceback_cell_last];
end

if size(traceback_cell,1)==1
    
    % only 1 main homologous block
    
    if isempty(gappy_traceback_cell)
        traceback_final=traceback_cell{1}.tr;
    elseif size(gappy_traceback_cell,1) == 2
        traceback_final=[gappy_traceback_cell{1}.tr,traceback_cell{1}.tr,gappy_traceback_cell{2}.tr];
    else
        error('ERROR: merge_tracebacks : size of gappy_traceback_cell incorrect')
    end
    
else

    % more than one homologous block
    
    % -----------------------------------
    % gappy(1) first
    % hom_block(1)
    % gappy(2)
    % hom_block(2)
    % gappy(3) last
    %
    % size gappy = 3 ; size hom_block = 2
    % -----------------------------------
    if size(traceback_cell,1)+1 ~= size(gappy_traceback_cell,1)
        error('ERROR: merge_tracebacks : size of gappy_traceback_cell incorrect')
    end

    % first traceback
    traceback_final=gappy_traceback_cell{1}.tr;

    for k=1:size(traceback_cell,1)
        
        if isempty(traceback_cell{k}.tr)
            tr=[];
        else
            tr=traceback_cell{k}.tr;
        end
        
        traceback_final=[traceback_final,tr];
        
        if isempty(gappy_traceback_cell{k+1}.tr)
            tr=[];
        else
            tr=gappy_traceback_cell{k+1}.tr;
        end
        
        traceback_final=[traceback_final,tr];
    end

end