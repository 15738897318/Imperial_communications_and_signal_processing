function nc = music(array, Rxx, M, K)
% MUSCI algorithm
N = size(Rxx,1);
if nargin<=3
    K = N; % for spatital smoothing techniques
end

[E, D] = eig(Rxx); %eigenvalues and eigenvectors
D = diag(D);
[~,I] = sort(D);

E = E(:,I);
En = []; % eigenvectors of nosie subspace
for i=1:N-M
    En = [En E(:,N-M-i+1)];
end

nc = []; % gain of different directions
for azimuth = 0:180
    S = spv(array,[azimuth,0]);
    S = S(1:K);
    nc = [nc S'*(En*En')*S];
end

nc = -10*log10(nc);
end