function [C_selected,R_max] = selectSubset(Q, S, H, Lambda, neighBS, R_cell, Es, noise_pow, R_long_term)
%Select the optimal subset of users to schedule
%  [C_selected,R_max] = selectSubset(Q, S, H, Lambda, neighBS, R_cell, Es, noise_pow, R_long_term)
%Inputs:
%   Q: number of users
%   S: number of users in the subset
%   H: channels for all users
%   Lambda: path loss and shadowing between user and center BS
%   neighBS: number of the neighbourhood BS
%   R_cell: covariance matrix of the inter-cell interference for all users
%   Es: overall transmit power
%   noise_pow: power of noise
%   R_long_term: long-term average rate of each user
%Outputs:
%   C_selected: selected subset
%   R_max: maximum achievable rate of all user in the selected subset
%Date: 11/03/2021
%Author: Zhaolin Wang

Q_=1:Q;
C = nchoosek(Q_,S);
C_H = (C-1)*(neighBS+1) + 1;
nt = size(H,2);
s = Es / S;

PF_all = zeros(size(C_H,1), 1);
R_all = zeros(size(C_H,1), S);
for i = 1:size(C_H,1)
    R_cell_i = R_cell(:,:,C(i,:));
    Lambda_i = Lambda(C(i,:));
    R_long_term_i = R_long_term(C(i,:));
    Hii = H(:,:,C_H(i,:));
    Hi = zeros(S,nt);
    for j = 1:S
        Hi(j,:) = Hii(:,:,j);
    end
    
    % zero forcing precoder
    F = Hi' * inv(Hi * Hi');
    W = F ./ vecnorm(F); % ZFBF
    
    % proportional Fair Seduling
    PF = 0;
    for j = 1:S
        SINR = 1/Lambda_i(j) * s * abs(Hi(j,:) * W(:,j))^2 / (R_cell_i(j) + noise_pow);
        R = log2(1+SINR); % achievable rate
        PF = PF + R / R_long_term_i(j); % proportional fair
        R_all(i,j) = R;
    end
    PF_all(i) = PF;
    
end

[~,index] = max(PF_all);
C_selected = C(index,:);
R_max = R_all(index,:);
end

