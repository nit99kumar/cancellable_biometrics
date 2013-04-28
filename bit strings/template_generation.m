function[bit_string1] = template_generation(mint_data,pin,Wx,Wy,Wz,Cx,Cy,Cz)
    
    extra = [Wx/2,Wy/2,0];
    extra = extra';

    %finding the number of cells in the final matrix
    M = floor(Wx/Cx);
    N = floor(Wy/Cy);
    L = floor(Wz/Cz);
    
    % determine the size of the matrix
    [row ~] = size(mint_data);

    % defining the final matrix
    transformed_template = zeros(M,N,L);
    bit_string1 = zeros(row,M*N*L);

    % extract the minutiae data from matrix according to the classification
    coord = cell2mat(mint_data(:,(2:3)));
    angle = cell2mat(mint_data(:,4));
    type = mint_data(:,6);

    %converting the angle into radians
    for i = 1:row
        angle(i) = angle(i) * 11.25;
        angle(i) = (angle(i) / 180) * pi;
    end
    
    % performing the transformation on the first image
    for r = 1:row
        new_coord(:,1) = coord(:,1) - coord(r,1);
        new_coord(:,2) = -(coord(:,2) - coord(r,2));
        new_angle = angle - angle(r);
        
        % finding the transformation matrix
        mat = [cos(angle(r)) -sin(angle(r)) 0;
               sin(angle(r)) cos(angle(r)) 0;    
               0 0 1];
    
        % finding the transformed template
        for i = 1:row
            temp = [new_coord(i,1) new_coord(i,2) new_angle(i)];
            transformed_minutia = (mat * temp')+ extra;
    
            t = [floor(transformed_minutia(1)/Cx)
                 floor(transformed_minutia(2)/Cy)
                 floor(transformed_minutia(3)/Cz)];
    
             a = t(1); b = t(2); c = t(3);
    
             % checking the boundary condtions
             if(a <= 0)
                 a = 1;
             end
             if(b <= 0)
                 b = 1;
             end
             if(c == 0)
                 c = 1;
             end
             if(c < 0)
                 c = abs(c);
             end
             if(a > M)
                 a = M;
             end
             if(b > N)
                 b = N;
             end
             if(c > L)
                 c = L;
             end
             transformed_template(a,b,c) = transformed_template(a,b,c) + 1;
        end
    
        % setting the location in the transformed matrix to one if 
        % contains more than one minutia
        j = 1;
        for m = 1:M
            for n = 1:N
                for l = 1:L
                    if(transformed_template(m,n,l) > 1)
                        transformed_template(m,n,l) = 1;
                    else
                        transformed_template(m,n,l) = 0;
                    end
                    % generating the final template matrix
                    bit_string1(r,j) = transformed_template(m,n,l);
                    j = j+1;
                end
            end
        end
    
        % generating the permutation matrix according to the type of the
        % refernce minutia
        rand('twister',pin);
        [~, b] = sort(rand(M*N*L,2));
        if(strcmp(type(r),'RIG '))
            b = b(:,1);
        else
            b = b(:,2);
        end
        
        % permuting the original bitstring
        for j = 1:(M*N*L)
            a = b(j);
            c = bit_string1(r,j);
            bit_string1(r,j) = bit_string1(r,a);
            bit_string1(r,a) = c;
        end  
    end
    %disp bitstring1; disp (bit_string1);
end
