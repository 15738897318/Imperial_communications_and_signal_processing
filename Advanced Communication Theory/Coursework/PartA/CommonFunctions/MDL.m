% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimating the number of sources using MDL criterion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% RXX (NxN Complex) = Covariance matrix of received signal
% N (Integers) = Size of covariance matrix
% L (Integers) = Length of received signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% M_MDL = Number of sources
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [M_MDL] = MDL(Rxx,N,L)

eigenv = sort(real(eig(Rxx)), 'descend');
MDL = zeros(1,N);
for k = 0:N-1
    d = eigenv(k+1:N);
    a = vpa(prod(sign(d) .* abs(d) .^(1/(N-k))),6);
    b = (1/(N-k)) * sum(d);
    MDL(k+1) = -1 * log((a / b)^((N-k)*L)) + 1/2 * k*(2*N-k) * log(L);
end
[~,M_MDL] = min(MDL);
M_MDL = M_MDL - 1;

end

