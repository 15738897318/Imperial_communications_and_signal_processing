clc
clear all
close all

addpath('./functions/')

% Parameters
Q = 10; % user number
Es = 10^(46/10); % transmit power
noise_pow = 10^(-174/10); % noise power
neighBS = 6; % number of neighbouring BS
nt = 4; % transmiting antennas
nr = 1; % receving antennas
t = 0.5; % spatial correlation
epsilon = 0.85; % time correlation
tc = 50; %scheduling time scale
K = 1000; % time instance
X = 500; % drop number

% BS locations
interferer_loc = 500 * exp(1i * (0:2*pi/neighBS:(2*pi-2*pi/neighBS))).';
interferer_loc = [real(interferer_loc) imag(interferer_loc)];
% plotLocation(user_loc, interferer_loc);

% codebook for quantized procoding
[W1,W2] = codebook(); % W1 for 1 stream; W2 for 2 streams

R_average_all = zeros(X*Q,1);
for x = 1:X 
    x
    % user locations
    user_loc = locationGen(Q);

    % transmit correlation matrix of each user
    R = tranCorrMatrix(t,Q);

    % initial channel matrices
    % first (neighBS+1) matrices are for user 1, and so on
    H = sqrt(1/2) * (randn(nr,nt,Q*(neighBS+1)) + 1i * randn(nr,nt,Q*(neighBS+1)));

    R_long_term = zeros(Q,K);
    R_average = zeros(Q,K);
    for k = 1:K 
        H = GaussMarkov(H,epsilon);

        % covariance matrix of inter-cell interference
        R_cell = interCellR(user_loc,interferer_loc,H,W1,Es);

        R_max = maxAchieveRate(H, R, user_loc, R_cell, noise_pow, Es, W1, W2, neighBS);
        proportion = R_max ./ R_long_term(:,k);
        [~,max_index] = max(proportion);

        R_sheduled = zeros(Q,1);
        R_sheduled(max_index) = R_max(max_index);

        R_long_term(:,k+1) = (1-1/tc) * R_long_term(:,k) + 1/tc * R_sheduled;

        R_average(:,k) =  R_sheduled;
    end

    R_average = mean(R_average(:,200:end),2); 
    
    R_average_all((x-1)*Q+1:x*Q) = R_average;
end

save('R_nr_2_t_3','R_average_all','Q','Es','noise_pow','neighBS','nt','nr','t','epsilon','tc');