clc
clear all
close all
%% 1a
im1 = imread('cameraman.tif');
% im1 = imread('coins.png');
im1 = im2double(im1);
figure();
imshow(im1);
title('Original Image');
figure();
plotfft(im1,1);


%% 1b




%% 1c
imA = im2double(imread('img1.jpg'));
imB = im2double(imread('img2.jpg'));
% imA = im2double(imread('circles.png'));
% imB = im2double(imread('circlesBrightDark.png'));
figure();
subplot(2,2,1); imshow(imA);title('image A');
subplot(2,2,2); imshow(imB);title('image B');
[imC1,imC2] = swapAmPh(imA,imB);

subplot(2,2,3); imshow(real(imC1));title('amplitude of image A + phase of image B');
subplot(2,2,4); imshow(real(imC2));title('amplitude of image B + phase of image A');

%% 2a & 2b
clc
clear all

X = imread('autumn.tif');
figure();
subplot(1,2,1);
plotdct(X);
subplot(1,2,2);
plotfft(X,0);

%% 3
im3 = imread('cameraman.tif');
im3 = im2double(im3);
figure();
plothadamard(im3);



