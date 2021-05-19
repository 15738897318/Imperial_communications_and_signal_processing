clc
clear all
close all

addpath('./functions/')

% Parameters
Q = 7; % user number
Es = 10^(46/10); % transmit power
noise_pow = 10^(-174/10); % noise power
neighBS = 6; % number of neighbouring BS
nt = 64; % transmiting antennas
nr = 1; % receving antennas
% t = 0.5; % spatial correlation
epsilon = 0.85; % time correlation
tc = 50; %scheduling time scale
K = 1000; % time instance
X = 500; % drop number
S = 4; % size of subset 

% BS locations
interferer_loc = 500 * exp(1i * (0:2*pi/neighBS:(2*pi-2*pi/neighBS))).';
interferer_loc = [real(interferer_loc) imag(interferer_loc)];
% plotLocation(user_loc, interferer_loc);

R_average_all = zeros(X*Q,1);
for x = 1:X 
    x
    % user locations
    user_loc = locationGen(Q);
    
    Lambda = pathLoss_center(Q, user_loc);

    % initial channel matrices
    % first (neighBS+1) matrices are for user 1, and so on
    H = sqrt(1/2) * (randn(nr,nt,Q*(neighBS+1)) + 1i * randn(nr,nt,Q*(neighBS+1)));
    
    R_long_term = zeros(Q,K);
    R_average = zeros(Q,K);
    for k = 1:K 
        H = GaussMarkov(H,epsilon);

        % covariance matrix of inter-cell interference
        R_cell = interCellR(user_loc,interferer_loc,H,Es);
        [C_selected,R_max] = selectSubset(Q, S, H, Lambda, neighBS, R_cell, Es, noise_pow, R_long_term(:,k));
        
        R_instan = zeros(Q,1);
        R_instan(C_selected,:) = R_max';
        R_long_term(:,k+1) = R_long_term(:,k) + R_instan;  
        
        R_average(:,k) = R_instan;
        
    end

    R_average = mean(R_average(:,200:end),2); 
    
    R_average_all((x-1)*Q+1:x*Q) = R_average;
end

save('R_7_64.mat','nt','Q','S','R_average_all');