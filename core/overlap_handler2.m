function coords=overlap_handler2(blocks,lk_v,d_shift)

%%
% fid=fopen('lk_c','w');
% for i=1:size(lk_v,2)
%     %lk=lk_v{i};
%     for j=1:length(lk_v{i})
%        fprintf(fid,'%9.7f ',lk_v{i}(j));
%     end
%     fprintf(fid,'\n');
% end
% fclose(fid);
%
% stop()
%
%%
display('blocks')
blocks
% display('d_shift')
% d_shift
%%
d_shift=d_shift(1);
blocks(:,3)=blocks(:,3)-d_shift;
blocks(:,4)=blocks(:,4)-d_shift;
%%
[~,idx]=sort(blocks(:,1),'asc');
blocks=blocks(idx,:);
[~,Y]=sort(blocks(:,3),'asc');

X=1:size(blocks,1);
X=X';

root=connect_blocks2(X,Y,blocks);

postOrderTraversal(root)

LEAVES=[];
LEAVES=traverseTree(root,LEAVES);


LEAVES


%%
%%%%% TEST %%%%%%%%%%%%
% blocks
%
% for i=1:size(blocks,1)
%     b=blocks(i,:);
%
%     h=b(2)-b(1);
%     w=b(4)-b(3);
%
%     b_size=[h,w]
% end
%
% for i=1:length(lk_v)
%     length(lk_v{i})
% end
%
% stop()

%debug_p(p)
%%%%% TEST %%%%%%%%%%%%
%%
flag_longest_path=false;
p=connect_blocks(Y,flag_longest_path);
%%
ppp=blocks;
%l1=d_shift;
figure
hold on
for i=1:size(ppp,1)
    %ppp(i,3)=blocks(i,3)-l1;
    %ppp(i,4)=blocks(i,4)-l1;
    
    plot([ppp(i,3) ppp(i,4)],[ppp(i,2) ppp(i,2)],'ob-')
    plot([ppp(i,4) ppp(i,4)],[ppp(i,2) ppp(i,1)],'ob-')
    plot([ppp(i,3) ppp(i,3)],[ppp(i,2) ppp(i,1)],'ob-')
    plot([ppp(i,3) ppp(i,4)],[ppp(i,1) ppp(i,1)],'ob-')
    text((ppp(i,3)+ppp(i,4))/2,(ppp(i,2)+ppp(i,1))/2,num2str(i))
    
end

% for i=1:length(p)
%     for j=1:length(p{i})
%        for k=1:length(p{i}{j}.path)-1
%            pi=p{i}{j}.path(k);
%            pj=p{i}{j}.path(k+1);
%            xx=ppp(pi,:);
%            yy=ppp(pj,:);
%            xxx=[(xx(3)+xx(4))/2,(xx(2)+xx(1))/2]
%            yyy=[(yy(3)+yy(4))/2,(yy(2)+yy(1))/2]
%            plot([xxx(1),yyy(1)],[xxx(2),yyy(2)],'*r-')
%        end
%     end
% end

for i=1:length(LEAVES)
    ll=LEAVES(i);
    while ~isempty(ll.Parent.Parent)
        pi=ll.ID;
        pj=ll.Parent.ID;
        xx=ppp(pi,:);
        yy=ppp(pj,:);
        xxx=[(xx(3)+xx(4))/2,(xx(2)+xx(1))/2];
        yyy=[(yy(3)+yy(4))/2,(yy(2)+yy(1))/2];
        plot([xxx(1),yyy(1)],[xxx(2),yyy(2)],'*r-')
        ll=ll.Parent;
    end
end

hold off

axis ij
axis square
daspect([1 1 1])


stop()

%%
for k=1:size(p,2)
    for j=1:size(p{k},2)
        path=p{k}{j}.path;
        p{k}{j}.lk=cell(length(path),1);
        p{k}{j}.blocks=zeros(length(path),4);
        for i=1:length(path)
            ti=Y(path(i));
            p{k}{j}.lk{i}=lk_v{ti};
            p{k}{j}.blocks(i,:)=blocks(ti,:);
        end
    end
end
%%
% for i=1:size(p,2)
%     for j=1:size(p{i},2)
%         msg=strcat('p{',num2str(i),'}{',num2str(j),'}');
%         display(msg)
%         p{i}{j}
%     end
% end
% stop()
%%
% for k=1:size(p,2)
%     for j=1:size(p{k},2)
%         path=p{k}{j}.path;
%         p{k}{j}.blocks=zeros(length(path),4);
%         for i=1:length(path)
%             ti=Y(path(i));
%             p{k}{j}.blocks(i,:)=blocks(ti,:);
%         end
%     end
% end
%%
% for i=1:size(p,2)
%     for j=1:size(p{i},2)
%         msg=strcat('p{',num2str(i),'}{',num2str(j),'}');
%         display(msg)
%         p{i}{j}
%         p{i}{j}.blocks
%     end
% end
% stop()
%%
% I=zeros(1200,1200);
% for i=1:size(p,2)
%     for j=1:size(p{i},2)
%         I=0*I;
%         coords=p{i}{j}.blocks;
%         figure
%         subplot(1,2,1)
%         plot_blocks(coords,I)
%     end
% end
%






% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% hold on
% k=0;
% for i=1:size(p,2)
%     for j=1:size(p{i},2)
%         [i,j]
%         lk=p{i}{j}.lk;
%         for w=1:length(lk)
%             plot(lk{w},'.k-')
%         end
%         k=k+1;
%     end
% end
% hold off
% k
% stop()
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=1:length(lk_c)
%     figure
%     a=coords(i,1);
%     b=coords(i,2);
%     c=coords(i,3);
%     d=coords(i,4);
%     plot(lk_c{i})
%     title(strcat(num2str(b-a+1),';',num2str(d-c+1)))
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% stop()





%%
% figure
% hold on


flag_all_resolved=false;
while (~flag_all_resolved)
    
    flag_all_resolved=true;
    
    for k=1:size(p,2)
        for j=1:size(p{k},2)
            
            p_path=p{k}{j}.path;
            p_lk=p{k}{j}.lk;
            p_blocks=p{k}{j}.blocks;
            
            
            
            
            
            
            %             display('vvvvvvvvvvvvvvvv')
            %             display('overlap_handler2')
            %             p_path
            %             p_lk
            %             p_blocks
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%
            %             for w=1:length(p_lk)
            %                 plot(p_lk{w},'.r-')
            %             end
            %%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            
            
            [f_path,f_lk,f_blocks,flag_all_resolved]=resolve_path(p_path,p_lk,p_blocks);
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%
            %             for w=1:length(f_lk)
            %                 plot(f_lk{w},'.b-')
            %             end
            %%%%%%%%%%%%%%%%%%%%%%%%%
            
            %
            %             f_path
            %             f_lk
            %             f_blocks
            %             display('^^^^^^^^^^^^^^^^')
            
            %             stop()
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %sort
            [~,idx]=sort(f_blocks(:,1),'asc');
            f_path=f_path(idx);
            f_lk=f_lk(idx);
            f_blocks=f_blocks(idx,:);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            display('=========================')
            display('sorted')
            f_blocks
            display('=========================')
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            p{k}{j}.path=f_path;
            p{k}{j}.lk=f_lk;
            p{k}{j}.blocks=f_blocks;
            
            %             f_path
            %             f_lk
            %             f_blocks
            %
            %             stop()
        end
    end
end



% hold off
% stop()

%%
% I=zeros(22,22);
% for i=1:size(p,2)
%     for j=1:size(p{i},2)
%         I=0*I;
%         coords=p{i}{j}.blocks;
%         figure
%         subplot(1,2,1)
%         plot_blocks(coords,I)
%     end
% end
%%
% display('PRINT FINAL P')
%
% for k=1:size(p,2)
%     for j=1:size(p{k},2)
%         p{k}{j}
%     end
% end

%%
max_score=-inf;
for k=1:size(p,2)
    for j=1:size(p{k},2)
        lk=p{k}{j}.lk;
        s=0;
        for i=1:length(lk)
            %s=s+sum(lk{i});
            s=s+length(lk{i});
        end
        if s>max_score
            max_score=s;
            max_k=k;
            max_j=j;
        end
    end
end

coords=p{max_k}{max_j}.blocks;
%%
if false %skip final check
    %p
    %coords
    % I=uint32(zeros(h,w));
    % for k=1:size(p,2)
    %     if ~isempty(p{k})
    %         for j=1:size(p{k},2)
    %             figure
    %             plot_blocks(p{k}{j}.blocks,I)
    %         end
    %     end
    % end
    %% final check
    for k=1:size(p,2)
        for j=1:size(p{k},2)
            t=p{k}{j}.path;
            for i=1:length(t)-1
                for z=i+1:length(t)
                    
                    H(1,:)=p{k}{j}.blocks(i,:);
                    H(2,:)=p{k}{j}.blocks(z,:);
                    
                    a1=H(1,1);b1=H(1,2);a2=H(1,3);b2=H(1,4);
                    c1=H(2,1);d1=H(2,2);c2=H(2,3);d2=H(2,4);
                    
                    code1=region2code(a1,b1,c1,d1);
                    code2=region2code(a2,b2,c2,d2);
                    type=overlap_table(code1,code2);
                    
                    if strcmp(type,'normal')
                        
                    else
                        
                        display('EEEEEEEEEEEEEEEEEEEEEEEEE')
                        H(1,:)
                        H(2,:)
                        display('EEEEEEEEEEEEEEEEEEEEEEEEE')
                        error('ERROR: overlap not handled')
                    end
                    
                end
            end
        end
    end
    
    
end
%%
coords(:,3)=coords(:,3)+d_shift;
coords(:,4)=coords(:,4)+d_shift;
%%
% display('coords')
% coords
% stop()
