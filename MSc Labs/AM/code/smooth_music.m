function nc = smooth_music(array, Rxx, M, K)
% MUSCI algprithm with spatitial smoothing technique

L = size(Rxx, 1);
N = L-K+1;
Rxxs = zeros(K,K);
for i=1:N
    Rxxs=Rxxs+Rxx(i:i+K-1,i:i+K-1);
end
Rxxs = Rxxs/N; % smoothed covariance matrix

nc = music(array, Rxxs, M, K);
end