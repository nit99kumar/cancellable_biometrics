function [far] = FAR1(th,M)

    far = 0;
    s = 0;
    [~,raw] = xlsread('FVC2004DB2_list.xlsx');
    z = xlsread('pin.xlsx');
    for i = 1:1
        pin1 = z(i);
        for j = 1:1
            file1 = char(raw(i,j));
            for k = 1:2
                %pin2 = z(k);
                if(i == k)
                    continue;
                else
                    for l = 1:8
                        file2 = char(raw(k,l));
                        disp (file1);
                        disp (file2);
                        % read the minutiae data into a matrix from the input file
                        [~,~,mint_data1] = xlsread(strcat(file1,'.xlsx')); % template
                        [~,~,mint_data2] = xlsread(strcat(file2,'.xlsx')); % query
                    
                        %[~,~,mint_data1] = xlsread(file1); % template
                        %[~,~,mint_data2] = xlsread(file2); % query
                    
                        %[row1 ~] = size(mint_data1);
                        %[row2 ~] = size(mint_data2);
                    
                        %if (row2 < (0.75 * row1) || row2 > (1.25 * row1))
                        %    disp('match not possible');
                        %    s = s + 1;
                        %    disp s;disp (s);
                        %    continue;
                        %else
                        % transforming the bit strings
                        
                        template1 = template_generation1(mint_data1,pin1,M);%xlsread(strcat(file1,'.xlsx'));
                        template2 = template_generation1(mint_data2,pin1,M);%xlsread(strcat(file1,'.xlsx'));
                        
                        % matching the bit strings
                        flag = template_matching1(template1,template2,th);
                        if(flag == 1)
                            far = far +1;
                        end
                        disp (far);
                    end
                end
            end
        end
    end
end
    