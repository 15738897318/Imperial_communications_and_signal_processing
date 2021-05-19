im3 = imread('img3.jpg');
im4 = imread('img4.jpg');
im3_r = im3(:,:,1);
im3_g = im3(:,:,2);
im3_b = im3(:,:,3);
im4_r = im4(:,:,1);
im4_g = im4(:,:,2);
im4_b = im4(:,:,3);

h3_r = my_histogram(im3_r);
h3_g = my_histogram(im3_g);
h3_b = my_histogram(im3_b);

h4_r = my_histogram(im4_r);
s = size(im4_r);
h2_normal = h4_r ./ (s(1)*s(2));
[im3_m_r, h3_m_r] = histogram_model(h2_normal,im3_r);

h4_g = my_histogram(im4_g);
s = size(im4_g);
h2_normal = h4_g ./ (s(1)*s(2));
[im3_m_g, h3_m_g] = histogram_model(h2_normal,im3_g);

h4_b = my_histogram(im4_b);
s = size(im4_b);
h2_normal = h4_b ./ (s(1)*s(2));
[im3_m_b, h3_m_b] = histogram_model(h2_normal,im3_b);

im3_m = cat(3, im3_m_r,im3_m_g,im3_m_b);



figure;
subplot(3,4,1);imshow(im3); title('"Sky"');
subplot(3,4,2);bar(h3_r);title('Red histogram of "Sky"');
subplot(3,4,3);bar(h3_g);title('Green histogram of "Sky"');
subplot(3,4,4);bar(h3_b);title('Blue histogram of "Sky"');

subplot(3,4,5);imshow(im4);title('"Love"');
subplot(3,4,6);bar(h4_r);title('Red histogram of "Love"');
subplot(3,4,7);bar(h4_g);title('Green histogram of "Love"');
subplot(3,4,8);bar(h4_b);title('Blue histogram of "Love"');

subplot(3,4,9);imshow(im3_m); title('Modified "Sky"');
subplot(3,4,10);bar(h3_m_r);title('Modified Red histogram');
subplot(3,4,11);bar(h3_m_g);title('Modified Green histogram');
subplot(3,4,12);bar(h3_m_b);title('Modified Blue histogram');