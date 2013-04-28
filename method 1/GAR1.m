function [gar] = GAR1(th,M)

    gar = 0;
    [~,raw] = xlsread('FVC2004DB2_list.xlsx');
    z = xlsread('pin.xlsx');
    for i = 1:1
        pin1 = z(i);
        for j = 1:1
            file1 = char(raw(i,j));
            
            for k = 1:4
                file2 = char(raw(i,k));
                disp (file1);
                disp (file2);
                % read the minutiae data into a matrix from the input file
                [~,~,mint_data1] = xlsread(strcat(file1,'.xlsx')); % template
                [~,~,mint_data2] = xlsread(strcat(file2,'.xlsx')); % query
            
                %[~,~,mint_data1] = xlsread(file1); % template
                %[~,~,mint_data2] = xlsread(file2); % query
                    
                % transforming the bit strings
                %template1 = xlsread(strcat(file1,'.xlsx'));
                %template2 = xlsread(strcat(file1,'.xlsx'));
                template1 = template_generation1(mint_data1,pin1,M);
                template2 = template_generation1(mint_data2,pin1,M);
            
                % matching the bit strings
                flag = template_matching1(template1,template2,th);
                if(flag == 1)
                    gar = gar + 1;
                    disp gar; disp (gar);
                end
            end
        end
    end
    
end