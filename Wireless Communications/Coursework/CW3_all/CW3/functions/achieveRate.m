function [R] = achieveRate(P,H,user_loc,R_cell,noise_pow)
%Calculate the achievable rate 
%  [R] = achieveRate(P,H,user_loc,R_cell,noise_pow)
%Inputs:
%   P: precoder
%   H: channel matrix
%   user_loc: location of the user
%   R_cell: covariance matrix of inter-cell interference
%   noise_pow: power of the noise
%Outputs:
%   R: achievable rate
%Date: 28/02/2021
%Author: Zhaolin Wang

nr = size(H,1); % receiev antennas
d_BS = norm(user_loc)/1000; % distance from center BS
Lambda = pathLoss(d_BS); % large scale fading
r = size(P,2); % number of streams

R = 0;
for l = 1:r
    pl = P(:,l);
    Pm = P;
    Pm(:,l) = 0;
    
    % covariance matrix of noise plus interference
    Rnl = 1/Lambda * H * (Pm * Pm') * H' + R_cell + noise_pow * eye(nr);
    
    SINR = 1/Lambda * pl'*H'*inv(Rnl)*H*pl;
    R = R + real(log2(1+SINR));
end

end

