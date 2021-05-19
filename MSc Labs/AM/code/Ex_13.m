array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];

% random source signal from 3 directions
L = 250;
N = size(array, 1);
M = size(directions,1);
m = (randn(M,L) + 1i*randn(M,L)) / sqrt(2);

% random noise
sigma2 = 0.1;
noise = sqrt(sigma2) * (randn(N,L) + 1i*randn(N,L)) / sqrt(2);
S = spv(array,directions);

% received signal
X = S * m + noise;

% covariance matrix
Rxx = X*X' / length(X(1,:));

eigenv = sort(real(eig(Rxx)), 'descend');

%% AIC and MDL criterion
AIC = zeros(1,N);
MDL = zeros(1,N);
for k = 0:N-1
    a = vpa(prod(eigenv(k+1:N) .^(1/(N-k))),6);
    b = (1/(N-k)) * sum(eigenv(k+1:N));
    AIC(k+1) = -2 * log((a / b).^((N-k)*L)) + 2*k*(2*N-k);
    MDL(k+1) = -1 * log((a / b).^((N-k)*L)) + 1/2 * k*(2*N-k) * log(L);
end

[~,M_AIC] = min(AIC);
[~,M_MDL] = min(MDL);

M_AIC = M_AIC - 1;
M_MDL = M_MDL - 1;

