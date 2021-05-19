function [P,R_max] = selectPrecoder(W1,W2,H,user_loc,R_cell,noise_pow,Es)
%Select the best precoder from the codebook
%   [P,R_max] = selectPrecoder(W1,W2,H,user_loc,R_cell,noise_pow,Es)
%Inputs:
%   W1: codebook of the precoders for 1 stream
%   W2: codebook of the preciders for 2 streams
%   H: channels for all users
%   user_loc: locations of the users
%   R_cell: covariance matrix of the inter-cell interference for all users
%   noise_pow: power of noise
%   Es: overall transmit power
%Outputs:
%   P: selected precoder
%   R_max: the rate achieved by the selected precoder
%Date: 29/12/2020
%Author: Zhaolin Wang


nr = size(H,1);

index_1 = 0;
R_max_1 = 0; % maximum achievable rate for rank 1
for i = 1:size(W1,3)
    r = 1;
    P_1 = W1(:,:,i) * sqrt(Es);
    R_1 = achieveRate(P_1,H,user_loc,R_cell,noise_pow);
    if R_1>R_max_1
        index_1 = i;
        R_max_1 = R_1;
    end
end

if nr == 1
    P = W1(:,:,index_1) * sqrt(Es); % selected precoder
    R_max = R_max_1;
else
    index_2 = 0;
    R_max_2 = 0; % maximum achievable rate for rank 2
    for i = 1:size(W2,3)
        r = 2;
        P_2 = W2(:,:,i) * sqrt(Es);
        R_2 = achieveRate(P_2,H,user_loc,R_cell,noise_pow);
        if R_1>R_max_2
            index_2 = i;
            R_max_2 = R_2;
        end
    end
    if R_max_2 > R_max_1
        r = 2;
        P = W2(:,:,index_2) * sqrt(Es); % selected precoder
        R_max = R_max_2;
    else
        r = 1;
        P = W1(:,:,index_1) * sqrt(Es); % selected precoder
        R_max = R_max_1;
    end 
end

end

