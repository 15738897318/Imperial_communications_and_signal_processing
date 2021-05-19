% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display the received image by converting bits back into R, B and G
% matrices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% bitsIn (Px1 Integers) = P demodulated bits of 1's and 0's
% Q (Integer) = Number of bits in the image
% x (Integer) = Number of pixels in image in x dimension
% y (Integer) = Number of pixels in image in y dimension
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fImageSink(bitsIn,Q,x,y)

img = zeros(x,y,3);
bitsIn = bitsIn(1:Q); % remove the padding zero
conveter = [2^7, 2^6, 2^5, 2^4, 2^3, 2^2, 2, 1];
Qc = Q/3;
for num = 1:3
    bits = bitsIn((num-1)*Qc+1 : num*Qc); % bits of one channel
    bits = reshape(bits,8,x,y);
    for i = 1:x
        for j = 1:y
            img(i,j,num) = conveter * bits(:,i,j); % convert from binary values to double value
        end
    end
end
img = uint8(img);
imshow(img);
end