clc
clear all
close all

im = im2gray(imread('torres.jpg'));
im = im2double(im);
figure();
imshow(im);title('Original image');

N = 16;
s = size(im,1);
numBlock = s / N;
K = 4; % compression ratio

% divide the image into small blocks
blocks = zeros(N,N,numBlock*numBlock);
for i=1:numBlock
    for j = 1:numBlock     
        b = im(N*(i-1)+1:N*i, N*(j-1)+1:N*j);
        index = numBlock*(i-1)+j;
        blocks(:,:,index) = b;    
    end  
end

%% Noiseless
% transmitter and channel
block_dct = zeros(size(blocks));
for i=1:numBlock
    for j = 1:numBlock     
        index = numBlock*(i-1)+j;
        b = blocks(:,:,index);
        b_dct = dct2(b);
        block_dct(1:N/2,1:N/2,index) = b_dct(1:N/2,1:N/2); % no noise
    end  
end

% receiver
im_receive = zeros(size(im));
for i=1:numBlock
    for j = 1:numBlock     
        index = numBlock*(i-1)+j;
        b_dct = block_dct(:,:,index);
        b = idct2(b_dct);
        im_receive(N*(i-1)+1:N*i, N*(j-1)+1:N*j) = b;
    end  
end

figure();
imshow(im_receive);title({'Reconstructed image (noiseless)'; ['Block Size = ' num2str(N) 'x' num2str(N)]});

%% Noisy
simga_2 = 0.0001;
% transmitter and channel
block_dct = zeros(size(blocks));
for i=1:numBlock
    for j = 1:numBlock     
        index = numBlock*(i-1)+j;
        b = blocks(:,:,index);
        b_dct = dct2(b);
        n = sqrt(simga_2) * randn(size(b_dct));
        block_dct(1:N/2,1:N/2,index) = b_dct(1:N/2,1:N/2);
        block_dct(:,:,index) = block_dct(:,:,index)+n;
    end  
end

% receiver
im_receive = zeros(size(im));
for i=1:numBlock
    for j = 1:numBlock     
        index = numBlock*(i-1)+j;
        b_dct = block_dct(:,:,index);
        b = idct2(b_dct);
        im_receive(N*(i-1)+1:N*i, N*(j-1)+1:N*j) = b;
    end  
end
figure();
imshow(im_receive);
title({['Reconstructed image (noisy \sigma^2=' num2str(simga_2) ')']; ['Block Size = ' num2str(N) 'x' num2str(N)]});


