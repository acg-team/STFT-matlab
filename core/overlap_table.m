function type=overlap_table(code1,code2)

if code1==999 || code2==999
    type='select';
else

    table=[
        'E','E','S','E','E','S','S','S','S','S','S','S','S'
        'E','E','E','E','E','S','S','S','S','S','S','S','S'
        'S','E','E','S','S','S','S','S','S','S','S','S','S'
        'E','E','S','E','E','S','S','S','S','S','S','S','S'
        'E','E','S','E','E','S','S','S','S','S','S','S','S'
        'S','S','S','S','S','O','O','O','S','S','S','S','S'
        'S','S','S','S','S','O','N','N','S','S','S','S','S'
        'S','S','S','S','S','O','N','N','S','S','S','S','S'
        'S','S','S','S','S','S','S','S','S','S','S','S','S'
        'S','S','S','S','S','S','S','S','S','S','S','S','S'
        'S','S','S','S','S','S','S','S','S','S','S','S','S'
        'S','S','S','S','S','S','S','S','S','S','S','S','S'
        'S','S','S','S','S','S','S','S','S','S','S','S','S'
        ];
    
    type=table(code1,code2);
    
    switch type
        case 'N'
            type='normal';
        case 'E'
            type='edge';
        case 'S'
            type='select';
        case 'O'
            type='overlap';
        otherwise
            type='select';
    end
    
end
%%
% if code1==999 || code2==999
%     type='select';
% else
%     
%     
%     % table=[ 'A','A','A','A','A','A','B','B'
%     %         'A','A','A','A','A','A','B','B'
%     %         'A','A','A','A','A','A','B','B'
%     %         'A','A','A','A','A','A','B','B'
%     %         'A','A','A','A','A','A','B','B'
%     %         'A','A','A','A','A','C','C','C'
%     %         'B','B','B','B','B','C','N','N'
%     %         'B','B','B','B','B','C','N','N'];
%     
%     table=['A','A','D','A','A','D','B','B'
%         'A','A','A','A','A','D','B','B'
%         'D','A','A','D','D','D','B','B'
%         'A','A','D','A','A','D','B','B'
%         'A','A','D','A','A','D','B','B'
%         'D','D','D','D','D','C','C','C'
%         'B','B','B','B','B','C','N','N'
%         'B','B','B','B','B','C','N','N'];
%     
%     type=table(code1,code2);
%     
%     switch type
%         case 'N'
%             type='normal';
%         case 'A'
%             type='edge';
%         case 'B'
%             type='select';
%         case 'C'
%             type='overlap';
%         case 'D'
%             type='ambiguous';
%         otherwise
%             type='select';
%     end
%     
% end