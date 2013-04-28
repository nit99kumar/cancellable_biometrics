clc;
clear all;

[~,raw] = xlsread('FVC2004DB2_list.xlsx');
M = (328 + 364);
z = zeros(100,1);
    for i = 1:100
        pin = randi([10000,99999],1);
        z(i) = pin;
        for j = 1:8
            file1 = char(raw(i,j));
            
            disp (file1);
            % read the minutiae data into a matrix from the input file
            [~,~,mint_data1] = xlsread(strcat(file1,'.xlsx')); % template
            
            % transforming the bit strings
            template1 = template_generation1(mint_data1,pin,M);
            
            a = num2str(i);
            b = num2str(j);
            c = strcat(a,'=',b,'.xlsx');
            xlswrite(c,template1);
        end
    end
xlswrite('pin.xlsx',z);