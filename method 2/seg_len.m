function[template] = seg_len(mint_data,pin)

coord = cell2mat(mint_data(:,2:3));
angle = cell2mat(mint_data(:,4));
type = mint_data(:,6);

[row ~] = size(mint_data);
dist_mat = zeros(row);
dist_max = zeros(row,1);
new_angle = zeros(row,1);

template = -ones(row,100);

% finding the distance matrix from a reference minutia to all other minutia
for i = 1:row
    for j = 1:row
        x1 = coord(i,1); y1 = coord(i,2);
        x2 = coord(j,1); y2 = coord(j,2);
        dist_mat(i,j) = distance(x1,y1,x2,y2);
    end
end

% finding the maximum distance for each refernce minutia
for i = 1:row
    dist_max(i) = max(dist_mat(i,:));
end

% finding the average of the maximum distances
seg_len = mean(dist_max);

% defining the threshold
d2 = floor(seg_len / 10);

% taking the horizontal direction as the reference
for i = 1:row
    new_angle(i) = angle(i);
    if (angle(i) > 8 && angle(i) < 24)
        new_angle(i) = mod((angle(i) + 16),32);
    end
end

% template generation
for i = 1:row
    
    part1 = 0;
    part2 = 0;
    part3 = 0;
    part4 = 0;
    part5 = 0;
    part6 = 0;
    part7 = 0;
    part8 = 0;
    part9 = 0;
    part10 = 0;

    if (new_angle(i) >= 0 && new_angle(i) <= 8)
        new_angle(i) = new_angle(i) * 11.25;
        new_angle(i) = (new_angle(i) / 180) * pi;
        new_angle(i) = (pi / 2) - new_angle(i);
    end        
    if (new_angle(i) >= 24 && new_angle(i) <= 31)
        new_angle(i) = new_angle(i) * 11.25;
        new_angle(i) = (new_angle(i) / 180) * pi;
        new_angle(i) = ((2 * pi) - new_angle(i)) + (pi / 2);
    end
    
    % slope of line and its perpendicular
    m1 = tan(new_angle(i));
    m2 = -(1 / m1);
    a1 = coord(i,1); b1 = coord(i,2);
    for j = 1:row
        a2 = coord(j,1); b2 = coord(j,2);
        x = ((b1 - b2) + ((a2 * m2) + (a1 * m1))) / (m2 - m1);
        y = b1 + m1*(((b1 - b2) + ((a2 * m2) - (a1 * m2))) / (m2 - m1));
        d1 = floor(distance(a1,b1,x,y));
        if (d1 <= d2)
            part1 = part1 + 1;
        end
        if(d1 > d2 && d1 <= (2 * d2))
            part2 = part2 + 1;
        end
        if(d1 > (2 * d2) && d1 <= (3 * d2))
            part3 = part3 + 1;
        end
        if(d1 > (3 * d2) && d1 <= (4 * d2))
            part4 = part4 + 1;
        end
        if(d1 > (4 * d2) && d1 <= (5 * d2))
            part5 = part5 + 1;
        end
        if(d1 > (5 * d2) && d1 <= (6 * d2))
            part6 = part6 + 1;
        end 
        if(d1 > (6 * d2) && d1 <= (7 * d2))
            part7 = part7 + 1;
        end
        if(d1 > (7 * d2) && d1 <= (8 * d2))
            part8 = part8 + 1;
        end 
        if(d1 > (8 * d2) && d1 <= (9 * d2))
            part9 = part9 + 1;
        end 
        if(d1 > (9 * d2) && d1 <= (10 * d2))
            part10 = part10 + 1;
        end 
    end
    %disp p1; disp(part1);
    %disp p2; disp(part2);
    %disp p3; disp(part3);
    %disp p4; disp(part4);
    %disp p5; disp(part5);
    template(i,1) = part1;
    template(i,2) = part2;
    template(i,3) = part3;
    template(i,4) = part4;
    template(i,5) = part5;
    template(i,6) = part6;
    template(i,7) = part7;
    template(i,8) = part8;
    template(i,9) = part9;
    template(i,10) = part10;
    
    % generating the permutation matrix according to the type of the
    % refernce minutia
    rand('twister',pin);
    [~, b] = sort(rand(100,2));
    if(strcmp(type(i),'RIG '))
        b = b(:,1);
    else
        b = b(:,2);
    end

    % permutation of the generated template according to the user pin
    % permuting the original bitstring
    for r = 1:100
        a = b(r);
        c = template(i,r);
        template(i,r) = template(i,a);
        template(i,a) = c;
    end
end