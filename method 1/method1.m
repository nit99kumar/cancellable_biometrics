%clc;
%clear all;

% maximum city block distance
M = 328 + 364;
 
% user pin
%pin1 = 98547;
%pin2 = 98547;

% thresholds
th = 0.02;

%mint_data1 = xlsread('101_1.xlsx'); % template
%mint_data2 = xlsread('102_2.xlsx'); % query

%template1 = template_generation1(mint_data1,pin1,M);
%template2 = template_generation1(mint_data2,pin2,M);

%template_matching1(template1,template2,th);

% calculating GAR
disp calculating_GAR;
gar = GAR1(th,M);

% calculating FAR
disp calculating_FAR;
%far = FAR1(th,M);

% displaying the result
disp gar;disp (gar/640);
%disp far;disp (far/5760);
