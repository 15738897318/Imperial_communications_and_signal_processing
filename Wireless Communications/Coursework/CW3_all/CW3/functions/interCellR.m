function [R_cell] = interCellR(user_loc,interferer_loc,H,W,Es)
%Generate the covaricance matrix of the inter-cell interference
%   [R_cell] = interCellR(user_loc,interferer_loc,H,W,Es)
%Inputs:
%   user_loc: locations of users
%   interferer_loc: locations of interferers
%   H: channel matrices
%   W: codebook of precoders
%   Es: transmit power
%Outputs:
%   R_cell: covariance matrix of inter-cell interference
%Date: 27/02/2021
%Author: Zhaolin Wang

nr = size(H,1); % receive antennas
neighBS = size(interferer_loc,1);
Q = size(user_loc,1);
[~,r,precode_num] = size(W); % precode_num - number of precoders; r - number of streams
if r == 1 % 1 streams
    S = Es;
elseif r==2 % 2 streams
    S = Es/2 * eye(2); % uniform power allocation
else
    error('Error! Only support 1 or 2 streams');
end

R_cell = zeros(nr, nr, Q); % covariance matrix of inter-cell interference
for q = 1:Q
    user_loc_q = user_loc(q,:);
    d_infer = sum(abs(user_loc_q - interferer_loc).^2,2).^(1/2) ./1000; % distance from interferers
    Lambda = pathLoss(d_infer); % large scale fading for user q    
    Hq = H(:,:,(q-1)*(neighBS+1) + 1:q*(neighBS+1)); % channel matrices for user q
    
    for j = 1:neighBS
        index = round(rand(1) * (precode_num-1)) + 1;
        Wj = W(:,:,index); % random precoding
        Hqj = Hq(:,:,j+1);
        R_cell(:,:,q) = R_cell(:,:,q) + 1/Lambda(j) * Hqj * Wj * S * Wj' * Hqj';
    end   
end

end

