input_image = imread('101_1.tif');figure;imshow(input_image);title('input_image');
L = max(max(input_image));
input_image=medfilt2(input_image,[3 3]);
lower = 25;%input('lower limit= ');
upper = 100;%input('upper limit= ');

alpha = 0.03;%input('alpha = ');
beta = 0.25;%input('beta = ');
gamma = 1.6;%input('gamma = ');

va = alpha * lower;
vb = beta * (upper - lower) + va;

[M N] = size(input_image);

for i = 1:M
    for j = 1:N
        if(input_image(i,j) < lower)
            output_image(i,j) = alpha * input_image(i,j);
        end
        if(input_image(i,j) > lower && input_image(i,j) < upper)
            output_image(i,j) = beta * (input_image(i,j) - lower) + va;
        end
        if(input_image(i,j) > upper)
            output_image(i,j) = gamma * (input_image(i,j) - upper) + vb;
        end
    end
end
figure;imshow(input_image);title('input_image');
figure;imshow(output_image);title('enhanced_image');