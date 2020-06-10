function P=connect_blocks(Y,flag_longest_path)

N=size(Y,1);

P=[];
ip=1;
for i=1:N-1
    
    path=[];
    idx=1;
    for j=i+1:N
        if Y(j)>Y(i)
            path{idx}.path=[i,j];
            idx=idx+1;
        end
    end
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%
    display('XXXXXXXXXXXXXXXXXXXXXXXXXXX')
    whos path
    for k=1:length(path)
       path{k}.path 
    end
    display('XXXXXXXXXXXXXXXXXXXXXXXXXXX')
    %%%%%%%%%%%%%%%%%%%%%
    
    
%     flag=true;
%     while(flag)
%         flag=false;
%         for j=1:size(path,2)
%             vi=path{j}.path;
%             ki=vi(end);
%             for k=ki+1:N
%                 if Y(k)>Y(ki)
%                     path{j}.path=[path{j}.path,Y(k)];
%                     flag=true;
%                 end
%             end
%         end
%     end
    
    for j=1:size(path,2)
        
        %vi=path{j}.path;
        
        flag=true;
        while(flag)
            flag=false;

            ki=path{j}.path(end);
            for k=ki+1:N
                ki=path{j}.path(end);
                if Y(k)>Y(ki)
                    path{j}.path=[path{j}.path,Y(k)];
                    flag=true;
                end
            end
        end
        
    end


    P{ip}=path;
    ip=ip+1;
end


%%
% if flag_longest_path
%     m=0;
%     for i=1:size(P,2)
%         for j=1:size(P{i},2)
%             if length(P{i}{j})>m
%                 m=length(P{i}{j});
%             end
%         end
%     end
%     
%     Pfinale=[];
%     ip=1;
%     for i=1:size(P,2)
%         for j=1:size(P{i},2)
%             if length(P{i}{j})==m
%                 Pfinale{ip}=P{i}{j};
%                 ip=ip+1;
%             end
%         end
%     end
%     
%     p=Pfinale;
%     
% else
%     
%     p=P;
%     
% end
