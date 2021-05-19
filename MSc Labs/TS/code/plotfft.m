function plotfft(img, shift)
if size(img,3) == 3
    img = rgb2gray(img);
end
img_fft = fft2(img);
if shift == 1
    img_fft = fftshift(img_fft);
end
colormap(jet(64)), imagesc(log(abs(img_fft))), colorbar
axis square;
title('Logarithmic amplitude of FFT');
end

