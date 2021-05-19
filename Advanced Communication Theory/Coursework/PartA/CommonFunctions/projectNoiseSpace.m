% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/23

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the projection matrix of noise subspace based on covariance matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% RXX (NxN Complex) = Covariance matrix of received signal
% L (Integers) = Length of received signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% Pn = projection matrix of noise subspace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Pn = projectNoiseSpace(Rxx,L)
N = size(Rxx,1);
M = MDL(Rxx,size(Rxx,1),L);

[E, D] = eig(Rxx); %eigenvalues and eigenvectors
D = diag(D);
[~,I] = sort(D,'descend');

E = E(:,I); 
En = E(:,M+1:end);% eigenvectors of nosie subspace

Pn = En * inv(En'*En) * En';
end

