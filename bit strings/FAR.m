function [far] = FAR(Wx,Wy,Wz,Cx,Cy,Cz,th,pin1,pin2)

    far = 0;
    [~,raw] = xlsread('FVC2004DB2_list.xlsx');
    for i = 1:100
        for j = 1:8
            file1 = char(raw(i,j));
            for k = 1:100
                if(i == k)
                    continue;
                end
                for l = 1:8
                    file2 = char(raw(k,l));
                    disp (file1);
                    disp (file2);
                    % read the minutiae data into a matrix from the input file
                    [~,~,mint_data1] = xlsread(strcat(file1,'.xlsx')); % template
                    [~,~,mint_data2] = xlsread(strcat(file2,'.xlsx')); % query
    
                    % transforming the bit strings
                    bit_string1 = template_generation(mint_data1,pin1,Wx,Wy,Wz,Cx,Cy,Cz);
                    bit_string2 = template_generation(mint_data2,pin2,Wx,Wy,Wz,Cx,Cy,Cz);
            
                    % matching the bit strings
                    flag = matching_bit_strings(bit_string1,bit_string2,th);
                    if(flag == 1)
                        far = far +1;
                        disp (far);
                    end
                end
            end
        end
    end
    
end