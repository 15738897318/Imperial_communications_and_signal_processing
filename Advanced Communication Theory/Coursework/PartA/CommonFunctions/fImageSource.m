% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reads an image file with AxB pixels and produces a column vector of bits
% of length Q=AxBx3x8 where 3 represents the R, G and B matrices used to
% represent the image and 8 represents an 8 bit integer. If P>Q then
% the vector is padded at the bottom with zeros.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% filename (String) = The file name of the image
% P (Integer) = Number of bits to produce at the output - Should be greater
% than or equal to Q=AxBx3x8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% bitsOut (Px1 Integers) = P bits (1's and 0's) representing the image
% x (Integer) = Number of pixels in image in x dimension
% y (Integer) = Number of pixels in image in y dimension
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [bitsOut,x,y]=fImageSource(filename,P)
% read the image
img = imread(filename);
[x,y,~] = size(img);

Q = x*y*3*8; % total number of bits used to represent the image

if P<Q error('P should larger or equal to x*y*3*8!'); end

Qc = x*y*8; % number of bits in one channel
bitsOut = zeros(P,1);
for num = 1:3
    channel = img(:,:,num); % one channel of the image
    bits = (dec2bin(channel) - '0')'; % convert the pixel values to binary values
    bits = bits(:);
    bitsOut((num-1)*Qc+1 : num*Qc) = bits;
end


end