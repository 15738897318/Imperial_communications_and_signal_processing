close all
clc
% im_created = zeros(128);
% for i = 1:32
%     for j = 1:32
%         im_created(4*(i-1)+1,4*(j-1)+1) = 1;
%     end
% end
% figure();
% imshow(im_created);title('Artificial Image');
% figure();
% plotfft(im_created,1);

% im_created = zeros(128);
% for i = 1:32
%         im_created(4*(i-1)+1,:) = 1;
% end
% figure();
% imshow(im_created);title('Artificial Image');
% figure();
% plotfft(im_created,1);
% 
% 
% im_created = zeros(128);
% for i = 1:128
%         im_created(i,:) = abs(cos(i*4*pi/128));
% end
% figure();
% imshow(im_created);title('Artificial Image');
% figure();
% plotfft(im_created,1);
% 
% 
im_created = zeros(128);
for i = 1:128
        im_created(i,:) = i/128;
end
figure();
imshow(im_created);title('Artificial Image');
figure();
plotfft(im_created,1);

