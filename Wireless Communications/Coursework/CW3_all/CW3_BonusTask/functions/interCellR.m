function [R_cell] = interCellR(user_loc,interferer_loc,H,Es)
%Generate the covaricance matrix of the inter-cell interference for
%Multi-user cases
%   [R_cell] = interCellR(user_loc,interferer_loc,H,W,Es)
%Inputs:
%   user_loc: locations of users
%   interferer_loc: locations of interferers
%   H: channel matrices
%   Es: transmit power
%Outputs:
%   R_cell: covariance matrix of inter-cell interference
%Date: 12/03/2021
%Author: Zhaolin Wang

nr = size(H,1); % receive antennas
nt = size(H,2); % transmit antennas
neighBS = size(interferer_loc,1);
Q = size(user_loc,1);

R_cell = zeros(nr, nr, Q); % covariance matrix of inter-cell interference
for q = 1:Q
    user_loc_q = user_loc(q,:);
    d_infer = sum(abs(user_loc_q - interferer_loc).^2,2).^(1/2) ./1000; % distance from interferers
    Lambda = pathLoss(d_infer); % large scale fading for user q    
    Hq = H(:,:,(q-1)*(neighBS+1) + 1:q*(neighBS+1)); % channel matrices for user q
    
    for j = 1:neighBS
        Hqj = Hq(:,:,j+1);
        R_cell(:,:,q) = R_cell(:,:,q) + 1/Lambda(j) * Es/nt * (Hqj * Hqj');
    end   
end

end

