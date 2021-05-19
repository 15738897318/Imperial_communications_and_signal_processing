function [imag_equalized, histogram]= equalization(imag)
% histogram equalization
s = size(imag);
num = s(1)*s(2);
histogram = my_histogram(imag);
histogram_normal = histogram/num;
map = zeros(1,256);
map(1) = histogram_normal(1);
imag_equalized = uint8(zeros(s(1),s(2)));

%calculate the transformation map
for i=2:256
    map(i) = histogram_normal(i)+map(i-1);
end

for i=1:256
    map(i) = uint8(255*map(i)+0.5);
end

%transform the image
for i=1:s(1)
    for j=1:s(2)
        imag_equalized(i,j) = map(imag(i,j)+1);
    end
end

histogram = my_histogram(imag_equalized);
end