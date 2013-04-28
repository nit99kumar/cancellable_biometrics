clc;
clear all;

[~,~,mint_data] = xlsread('1_1.xlsx');

% Defining the matrix size
Wx = 2 * 328;
Wy = 2 * 364;
Wz = 2 * pi;

% using the constants used for FVC2002DB2
Cx = 30;
Cy = 30;
Cz = pi/3;

%finding the number of cells in the final matrix
M = floor(Wx/Cx);
N = floor(Wy/Cy);
L = floor(Wz/Cz);

[row ~] = size(mint_data);

bit_strings = zeros(row,M*N*L,100);

for i = 1:100
    disp 'generating bit string number'; disp (i);
    pin = randi([10000,99999],1);
    bit_strings(:,:,i) = temp_gen(mint_data,pin,Wx,Wy,Wz,Cx,Cy,Cz);    
end

s = 0;
th = 0.30;
k = 1; 

disp 'now matching bit strings';

for i = 1:100
    bit_string1 = bit_strings(:,:,i);
    for j = i:100
        disp(i);
        disp(j);
        if(i == j)
            disp 'conitnue';
            continue;
        end
        bit_string2 = bit_strings(:,:,j);
        [flag,score] = match_bit(bit_string1,bit_string2,th);
        if flag == 1
            s = s + flag;
        end
        disp s; disp (s);
    end
end


