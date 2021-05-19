clc
clear all
close all

im = im2double(imread('torres.jpg'));
im = im2gray(im);
[width,height] = size(im);
figure();
subplot(1,3,1);
imshow(im); title('Original Image');

% Distortion Matrix (Moion Blur)
N = 5;
H=fspecial('gaussian',[7 7],1); % Gaussian Filter
degrade_im = imfilter(im, H, 'conv', 'circular'); % circular convolution
subplot(1,3,2);
imshow(degrade_im); title({'Degraded Image (Noiseless)'; '7x7 Gaussian blur (\sigma^2=1)'});

BSNR_dB = 20;
BSNR = 10^(BSNR_dB/10);
degrade_im_mean = mean(mean(degrade_im));
sigma_2 = sum(sum((degrade_im - degrade_im_mean).^2)) / (width*height) / BSNR;
n = sqrt(sigma_2) * randn(width,height);
degrade_im_noise = degrade_im + n;
subplot(1,3,3);
imshow(degrade_im_noise); title({'Degraded Image (Noisy)'; '7x7 Gaussian blur (\sigma^2=1) | BSNR=20dB'});


%% Inverse Filtering
restored_im = inverseFiltering(degrade_im, H);
restored_im_noise = inverseFiltering(degrade_im_noise, H);

figure();
subplot(1,2,1);imshow(restored_im); title('Restored Image (Noiseless)');
subplot(1,2,2);imshow(restored_im_noise); title('Restored Image (Noisy)');

% Psedoinverse Filtering
threshold = 1E-3;
restored_im_noise = pseudoinverseFiltering(degrade_im_noise, H, threshold);
figure();
subplot(1,2,1);imshow(restored_im_noise); title('Restored Image with a threshold of 10^-^3');

threshold = 1E-1;
restored_im_noise = pseudoinverseFiltering(degrade_im_noise, H, threshold);
subplot(1,2,2);imshow(restored_im_noise); title('Restored Image with a threshold of 10^-^1');

%% Wiener Filtering
restored_im = wienerFiltering(degrade_im, H, sigma_2);
figure();
imshow(restored_im); title({'Restored Image by Wiener Filter';'7x7 Gaussian blur (\sigma^2=1) | BSNR=20dB'});