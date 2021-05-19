function histogram = my_histogram(imag)
% histogram of the image
histogram = zeros(1,256);
s = size(imag);

for i=1:s(1)
    for j=1:s(2)
        value = imag(i,j);
        histogram(value+1) = histogram(value+1) + 1;        
    end
end

end