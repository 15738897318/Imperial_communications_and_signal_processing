function [imag_modeling,histogram] = histogram_model(target_histogram_normal,imag)
% modeling the histogram of the image to the target histogram
h = my_histogram(imag);
s = size(imag);
num = s(1)*s(2);
imag_modeling = uint8(zeros(s(1),s(2)));
h_normal = h/num; % normalize the histogram

%calculate the distribution function
target_histogram_normal_df = zeros(1,256);
h_df = zeros(1,256);
target_histogram_normal_df(1) = target_histogram_normal(1);
h_df(1) = h_normal(1);
for i=2:256
    target_histogram_normal_df(i) = target_histogram_normal(i)+target_histogram_normal_df(i-1);
    h_df(i) = h_normal(i)+h_df(i-1);
end

%calculate the transformation
map = zeros(1,256);
for i=1:256
    h = h_df(i);
    h_a_b_difference = abs(target_histogram_normal_df - h);
    
    %find the minimum difference
    a = find(h_a_b_difference == min(h_a_b_difference));
    map(i) = a(1);
end

%transform the image
for i=1:s(1)
    for j=1:s(2)
        imag_modeling(i,j) = map(imag(i,j)+1);
    end
end
histogram = my_histogram(imag_modeling);
end

