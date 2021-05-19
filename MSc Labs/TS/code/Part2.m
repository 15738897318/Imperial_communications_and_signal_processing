clc
clear all
close all

%% 1
I = imread('cameraman.tif');
figure;
for i = 1:4
    k = 2^i*16;
    J = histeq(I, k);
    subplot(4,2,2*i-1), imhist(J,256); title(['Histogram with ' num2str(k) ' bins']);axis tight;
    subplot(4,2,2*i), imshow(J); title(['Image equalised by ' num2str(k) ' bins histogram']); 
end


%% 2
clear all
im1 = imread('cameraman.tif');
% im2 = imread('circles.png');
% im2 = im2uint8(im2);

im2 = imread('pout.tif');
h1 = my_histogram(im1);
h2 = my_histogram(im2);
figure;
subplot(3,2,1); imshow(im1); title('Image A');
subplot(3,2,2); bar(h1); title('Histogram of Image A');
subplot(3,2,3); imshow(im2); title('Image B');
subplot(3,2,4); bar(h2); title('Histogram of Image B');

s = size(im2);
h2_normal = h2 ./ (s(1)*s(2));

[im1_m, h1_m] = histogram_model(h2_normal,im1);
subplot(3,2,5); imshow(im1_m); title('Image A with Histogram of Image B');
subplot(3,2,6); bar(h1_m); title('Histogram of new Image A');


%% 3
clear all
I = imread('trees.tif');
figure;
subplot(2,2,1), imshow(edge(I,'sobel'));title('Sobel');
subplot(2,2,2), imshow(edge(I,'roberts'));title('Roberts');
subplot(2,2,3), imshow(edge(I,'prewitt'));title('Prewitt');
subplot(2,2,4), imshow(edge(I,'Log'));title('Log');

I = im2double(I);
% sobel
kernal_1 = [0 1 2; -1 0 1; -2 -1 0];
kernal_2 = [-2 -1 0; -1 0 1; 0 1 2];

figure;
subplot(1,2,1); imshow(my_edge(I,kernal_1));title('Edges inclined at -45^o (Sobel)');
subplot(1,2,2); imshow(my_edge(I,kernal_2));title('Edges inclined at +45^o (Sobel)');

%% 4
X = imread('autumn.tif');
I = rgb2gray(X);
J = imnoise(I,'salt & pepper',0.15);
figure();
subplot(2,2,1), imshow(J); title('Image with salt & pepper noise (noise density = 0.15)');

d = [3,5,7];
for i=1:3
    K = medfilt2(J,[d(i) d(i)]);
    s = num2str(d(i));
    subplot(2,2,i+1), imshow(K); title(['Median Filter ' s 'x' s]);  
end










