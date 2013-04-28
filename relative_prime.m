clc;
clear all;

k = 0;
final = zeros(1000,1);
tcount = 0;
for i = 1:1000
    for j = (i+1):1000
        tcount = tcount + 1;
        fcount = 0;
        disp i_j; disp([i,j]);
        
        z = 1;
        temp2 = zeros();
        for m = 1:j
            if(mod(j,m) == 0)
                temp2(z) = m;
                z = z + 1;
            end
        end
        [~,b] = size(temp2);
        %disp temp2; disp (temp2);
        
        for f = i:(j-1)
            y = 1;
            temp1 = zeros();
            for l = 1:f
                if(mod(f,l) == 0)
                    temp1(y) = l;
                    y = y + 1;
                end
            end
            %disp f; disp (f);
            %disp temp1; disp (temp1);
            [~,a] = size(temp1);
            count = 0;
            for r = 1:a
                for s = 1:b
                    if(temp1(r) == temp2(s))
                        count = count + 1;
                    end
                end
            end
 
            %disp count; disp (count);
        
            if(count == 1)
                fcount = fcount + 1;
            end
            
            %disp fcount; disp (fcount);
            
        end
        
        final(fcount+1) = final(fcount+1) + 1;
        
        
    end
end
disp tcount;disp (tcount);
disp final;disp (final);
disp mean; disp (mean(final));
disp median; disp (median(final));
disp variance; disp (var(final));
plot(final);
        