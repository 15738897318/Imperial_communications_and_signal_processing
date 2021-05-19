function plotdct(img)
if size(img,3) == 3
    img = rgb2gray(img);
end
img_dct = dct2(img);
colormap(jet(64)), imagesc(log(abs(img_dct))), colorbar
axis square;
title('Logarithmic amplitude of DCT');
end

