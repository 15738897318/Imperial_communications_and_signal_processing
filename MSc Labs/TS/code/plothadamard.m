function plothadamard(img)

if size(img,3) == 3
    img = rgb2gray(img);
end

h1=size(img,1);      
h2=size(img,2); 

% Get ordered Hadamard matrix
H1 = orderedHadamard(h1);
H2 = orderedHadamard(h2);

% ordered Hadamard Transform
J=H1*img*H2/sqrt(h1*h2); 
subplot(1,2,1);
imshow(im2uint8(H1)); title('Ordered Hadamard Matrix');
subplot(1,2,2);
imshow(im2uint8(J)); title('Hadamard Transform of Image');

end

