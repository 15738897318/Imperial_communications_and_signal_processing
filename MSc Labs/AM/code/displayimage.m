function displayimage(x, image_size, figurenumber,plottitle);

figure(figurenumber);
x = reshape(x,image_size);
imagesc(uint8(abs(x)));
title(plottitle);
