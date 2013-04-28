[~,~,list] = xlsread('FVC2004DB2_list.xlsx');
[row,col] = size(list);
for i = 1:row
    for j = 1:col
        file = char(list(i,j));
        file = strcat(file,'.xlsx');
        disp (file);
        mint_data = xlsread(file);
    end
end