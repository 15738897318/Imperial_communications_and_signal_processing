function restored_im = wienerFiltering(degrade_im,H,noise_pow)
[width,height] = size(degrade_im);
N = size(H,1);

H_padding = zeros(width,height); 
H_padding(1:N,1:N) = H; % padding the distortion matrix with zeros
H_padding_fft = fft2(H_padding);
degrade_im_fft = fft2(degrade_im);

pow_im = abs(degrade_im_fft).^2; % Power Spectrum of degrade image

W = (pow_im .* conj(H_padding_fft)) ./ (pow_im .* abs(H_padding_fft).^2 + noise_pow); % Wiener Filter
restored_im_fft = W .* degrade_im_fft;
restored_im = ifft2(restored_im_fft);
end

