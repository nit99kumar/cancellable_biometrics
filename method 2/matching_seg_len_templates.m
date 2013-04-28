function[flag] = matching_seg_len_templates(template1, template2,th)

    %finding the number of template bit strings in each array
    [row1 ~] = size(template1);
    [row2 ~] = size(template2);
    
    SAij = zeros(row2,row1);
    sum1 = zeros(row1,1);
    sum2 = zeros(row1,1);
    SAmax = zeros(row2,1);
    S = zeros(row2,1);
    T = 0;
    Nei = zeros(row1,1);
    Nqj = zeros(row2,1);
    
    % finding the number of digits which are ~= -1 in the template bit strings
    for i = 1:row1
        for j = 1:100
            if(template1(i,j) ~= -1)
                Nei(i) = Nei(i) + 1;
            end
        end
    end
    
    % finding the number of digits which are ~= -1 in the query bit strings
    for i = 1:row2
        for j = 1:100
            if(template2(i,j) ~= -1)
                Nqj(i) = Nqj(i) + 1;
            end
        end
    end
    
    % similarity score between bitstrings
    for j = 1:row2
        for i = 1:row1
        sum1(i) = Nqj(j) + Nei(i);
            
            % finding the number of common ones in the enrolled and the
            % query fingerprint
            s = 0;
            for k = 1:100
                if(template2(j,k) ~= -1 && template1(i,k) ~= -1 && template2(j,k) == template1(i,k))
                    s = s + 1;
                end
            end
            sum2(i) = s;
            %disp sum2;disp (sum2);
            % calculating SAij
            e = Nei .* Nei;
            f = Nqj .* Nqj;
            SAij(j,i) = ((sum1(i) * sum2(i))) / (e(i)+f(j));
        end
    end
    
    % finding SAmax(j)
    for j = 1:row2
        SAmax(j) = max(SAij(j,:));
    end
    
    %finding S(j)
    for j = 1:row2
        if(SAmax(j) > 0)
            S(j) = SAmax(j);
        else
            S(j) = 0;
        end
    end
    % displaying the score values for all the minutiae templates
    %disp Sj; disp (S);
    % calculating T
    for j = 1:row2
        if(S(j) == 0)
            continue;
        else
            T = T + 1;
        end
    end
        
    %calculating the final score
    disp row2;disp (row2);
    disp row1;disp (row1);
    disp T;disp (T);
    score = sum(S) / T;
    disp score;disp (score);
    %if (T >= (row2 / 4) && score >= th)
    if(score >= 0.60)
        disp ('Match!');
        flag = 1;
    else
        disp('Not a match!');
        flag = 0;
    end
 end    