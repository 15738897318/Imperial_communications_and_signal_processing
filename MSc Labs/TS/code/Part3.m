clc 
clear all
close all
X = imread('autumn.tif');
I = rgb2gray(X);
figure;
subplot(2,3,1);imshow(I);title('Original Image');

for i = 10:20:100
    J = dct2(I);
    nz = find(abs(J)<i);
    J(nz) = zeros(size(nz));
    K = idct2(J)/255;
    subplot(2,3,(i+10)/20+1);imshow(K); title(['Threshold ' num2str(i)]); 
end

step_h = 206/2;
step_v = 345/5;

T = 0:20:200;
I_final = zeros(size(I));

for j = 1:5
    sv = (j-1) * step_v + 1;
    ev = j * step_v ;
    block = I(:,sv:ev);
    % DCT
    J = dct2(block);
    t = T(j);
    nz = find(abs(J)<t);
    J(nz) = zeros(size(nz));
    K = idct2(J)/255;
    I_final(:,sv:ev) = K;
end


figure;
imshow(I_final);title('5 smaller bolcks with 5 different threshold');



