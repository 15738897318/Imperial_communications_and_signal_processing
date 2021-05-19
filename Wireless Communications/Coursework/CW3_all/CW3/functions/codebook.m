function [W_1,W_2] = codebook()
%Generate the LTE codebook for 1 layer and 2 layers
%   [W_1,W_2] = codebook()
%Inputs:
%   None
%Outputs:
%   W1: LTE codebook for 1 layer
%   W2: LTE codebook for 2 layer
%Date: 27/02/2021
%Author: Zhaolin Wang


u = [1 -1 -1 -1;
    1 -1i 1 1i;
    1 1 -1 1;
    1 1i 1 -1i;
    1 (-1-1i)/sqrt(2) -1i (1-1i)/sqrt(2);
    1 (1-1i)/sqrt(2) 1i (-1-1i)/sqrt(2);
    1 (1+1i)/sqrt(2) -1i (-1+1i)/sqrt(2);
    1 (-1+1i)/sqrt(2) 1i (1+1i)/sqrt(2);
    1 -1 1 1;
    1 -1i -1 -1i;
    1 1 1 -1;
    1 1i -1 1i
    1 -1 -1 1;
    1 -1 1 -1;
    1 1 -1 -1;
    1 1 1 1];

index_2 = [1 4; 1 2; 1 2; 1 2; 1 4; 1 4; 1 3; 1 3; 1 2; 1 4; 1 3; 1 3;
    1 2; 1 3; 1 3; 1 2]; % index of columns when v=2

W_1 = zeros(4,1,size(u,1)); % precoders for v=1
W_2 = zeros(4,2,size(u,1)); % precoders for v=2
for i = 1:size(u,1)
    u_n = u(i,:).';
    W = eye(4) - 2* (u_n * u_n')/(u_n'*u_n);
    W_1(:,:,i) = W(:,1);
    W_2(:,:,i) = W(:,index_2(i,:)) / sqrt(2);
end
end

