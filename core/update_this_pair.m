function f=update_this_pair(f,i,N,pair)

if i==1 || N==1
    
    f{i} = pair;

elseif i>1 && i<N
    
    if length(pair)==2
        if length(f{i-1})==2
            f{i-1}{2} = pair{1};
        else
            f{i-1}{1} = pair{1};
        end
    else
        f{i-1} = f{i-1}(1);
    end
    f{i} = pair;
    
elseif i==N
    
    if length(pair)==2
        if length(f{N-1})==2
            f{N-1}{2} = pair{1};
        else
            f{N-1}{1} = pair{1};
        end
        f{N} = pair;
    else
        if length(f{N-1})==2
            if f{N-1}{2}.path == pair{1}.path
                f{N-1}{2} = pair{1};
            else
                f{N-1} = f{N-1}(1);
            end
            f{N} = pair;
        else
            if f{N-1}{1}.path == pair{1}.path
                f{N-1}{1} = pair{1};
                f=f(1:N-1);
%             else
%                 f{N} = pair;
            end
        end
    end
    
end




