function [flag] = template_matching1(template1, template2, th)
    disp here;
    %finding the number of templates in each array
    [row1 col1] = size(template1);
    [row2 col2] = size(template2);
    
    if(col1 ~= col2)% confirmation that pin is different
        disp('Not a match! [col1 ~=col2]');
        flag = 0;
    else
        SAij = zeros(row2,row1);
        SAmax = zeros(row2,1);
        S = zeros(row2,1);
        Nei = zeros(row1,1);
        Nqj = zeros(row2,1);
        sum1 = zeros(row1,1);
        T = 0;
        
        % finding the number of non zero elements in the template bit strings
        for i = 1:row1
            a = size(find(template1(i,:) ~= 0));
            Nei(i) = a(2);
        end
        % finding the number of non zero elements in the query bit strings
        for i = 1:row2
            a = size(find(template2(i,:) ~= 0));
            Nqj(i) = a(2);
        end
        
        % similarity score between bitstrings
        for j = 1:row2
            for i = 1:row1
                sum1(i) = Nqj(j) + Nei(i);
                % finding the number of common bits in the enrolled and the
                % query fingerprint
                s = 0;
                for k = 1:col1
                    if(template2(j,k) ~= -1 && template1(i,k) ~= -1 && template2(j,k) == template1(i,k))
                        s = s + 1;
                    end
                end
                e = Nei .* Nei;
                f = Nqj .* Nqj;
                SAij(j,i) = ((sum1(i) * s)) / (e(i)+f(j));
            end
        end
    
        %disp SAij; disp (SAij);
                
        % finding SAmax(j)
        for j = 1:row2
            SAmax(j) = max(SAij(j,:));
        end
        disp SAmax;disp (SAmax);
        %finding S(j)
        for j = 1:row2
            if(SAmax(j) > th)
                S(j) = SAmax(j);
            else
                S(j) = 0;
            end
        end
        
        % displaying the score values for all the minutiae templates
        % calculating T
        for j = 1:row2
            if(S(j) == 0)
                continue;
            else
                T = T + 1;
            end
        end
        
        %calculating the final score
        %disp S;disp (S);
        %disp row2;disp (row2);
        %disp row1;disp (row1);
        disp T;disp (T);
        score = sum(S) / T;
        disp score;disp (score);
        if (T > (row2 * 0.5) && score >= th)
        %if (score >= 0.3)
            disp ('Match!');
            flag = 1;
        else
            disp('Not a match!');
            flag = 0;
        end
    end
end