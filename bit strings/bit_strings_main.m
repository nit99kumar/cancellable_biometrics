clc;
clear all;

% Defining the matrix size
Wx = 2 * 328;
Wy = 2 * 364;
Wz = 2 * pi;

% using the constants used for FVC2002DB2
Cx = 30;
Cy = 30;
Cz = pi/3;

% thresholds
th = 0.30;

%mint_data1 = xlsread('101_1.xlsx'); % template
%mint_data2 = xlsread('101_3.xlsx'); % query
    
% transforming the bit strings
%bit_string1 = template_generation(mint_data1,pin1,Wx,Wy,Wz,Cx,Cy,Cz);
%bit_string2 = template_generation(mint_data2,pin2,Wx,Wy,Wz,Cx,Cy,Cz);
            
%flag = matching_bit_strings(bit_string1,bit_string2,th);

% calculating GAR
disp calculating_GAR;
% user pin for calculating GAR
pin1 = 94587;
pin2 = 94587;
%gar = GAR(Wx,Wy,Wz,Cx,Cy,Cz,th,pin1,pin2);

% calculating FAR
disp calculating_FAR;
% user pin for calculating GAR
pin1 = 94587;
pin2 = 12345;
far = FAR(Wx,Wy,Wz,Cx,Cy,Cz,th,pin1,pin2);

% displaying the result
%disp gar;disp (gar/160);
disp far;disp (far/1440);