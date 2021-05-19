function [imC1,imC2] = swapAmPh(imA,imB)
if size(imA,3) == 1 
    % for gray image
    [xA,yA] = size(imA);
    [xB,yB] = size(imB);
    x = max([xA xB]);
    y = max([yA yB]);
    imA_fft = fft2(imA);
    imA_ampl = zeros(x,y); % amplitude of image A
    imA_ampl(1:xA,1:yA) = abs(imA_fft);
    imA_pha = zeros(x,y); % phase of image A
    imA_pha(1:xA,1:yA) = angle(imA_fft);

    imB_fft = fft2(imB);
    imB_ampl = zeros(x,y); % amplitude of image B
    imB_ampl(1:xB,1:yB) = abs(imB_fft);
    imB_pha = zeros(x,y); % phase of image B
    imB_pha(1:xB,1:yB) = angle(imB_fft);
    
    % Swap the amplitude and phase
    imC1 = ifft2(imA_ampl .* exp(1i*imB_pha));
    imC2 = ifft2(imB_ampl .* exp(1i*imA_pha));
    
else
    % for coloured image
    [imC1R,imC2R] = swapAmPh(imA(:,:,1),imB(:,:,1));
    [imC1G,imC2G] = swapAmPh(imA(:,:,1),imB(:,:,2));
    [imC1B,imC2B] = swapAmPh(imA(:,:,1),imB(:,:,3));
    imC1 = cat(3,imC1R,imC1G,imC1B);
    imC2 = cat(3,imC2R,imC2G,imC2B);
end
end

