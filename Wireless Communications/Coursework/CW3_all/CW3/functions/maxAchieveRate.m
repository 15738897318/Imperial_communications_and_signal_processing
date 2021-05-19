function [R_max_all] = maxAchieveRate(H, R, user_loc, R_cell, noise_pow, Es, W1, W2, neighBS)
%Calculate the maximum achievable rate for all the users
%  [R_max_all] = maxAchieveRate(H, R, user_loc, R_cell, noise_pow, Es, W1, W2, neighBS)
%Inputs:
%   H: channels for all users
%   R: spatial correlation matrix for all users
%   user_loc: locations of the users
%   R_cell: covariance matrix of the inter-cell interference for all users
%   noise_pow: power of noise
%   Es: overall transmit power
%   W1: codebook of the precoders for 1 stream
%   W2: codebook of the preciders for 2 streams
%   neighBS: number of the neighbourhood BS
%Outputs:
%   R_max_all: maximum achievable rate of all user
%Date: 30/02/2021
%Author: Zhaolin Wang

Q = size(R,3);
R_max_all = zeros(Q,1);
for q = 1:Q
    Hq = H(:,:,(q-1)*(neighBS+1)+1);
    Hq = Hq * R(:,:,q)^(1/2);
    user_loc_q = user_loc(q,:);
    [~,R_max] = selectPrecoder(W1,W2,Hq,user_loc_q,R_cell(:,:,q),noise_pow,Es);
    R_max_all(q) = R_max;
end
end

