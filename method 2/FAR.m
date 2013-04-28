function [far] = FAR(pin1,pin2)

    far = 0;
    [~,raw] = xlsread('FVC2004DB2_list.xlsx');
    for i = 1:100
        for j = 1:2
            file1 = char(raw(i,j));
            for k = 1:100
                if(i == k)
                    continue;
                end
                for l = 1:2
                    file2 = char(raw(k,l));
                    disp (file1);
                    disp (file2);
                    % read the minutiae data into a matrix from the input file
                    [~,~,mint_data1] = xlsread(strcat(file1,'.xlsx')); % template
                    [~,~,mint_data2] = xlsread(strcat(file2,'.xlsx')); % query
    
                    % transforming the bit strings
                    template1 = seg_len(mint_data1,pin1);
                    template2 = seg_len(mint_data2,pin2);
            
                    % matching the bit strings
                    flag = matching_seg_len_templates(template1,template2);
                    if(flag == 1)
                        far = far +1;
                        disp (far);
                    end
                end
            end
        end
    end
    
end