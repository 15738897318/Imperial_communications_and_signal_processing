function [C] = codebook(symbol)
%CODEBOOK Summary of this function goes here
%   Detailed explanation goes here
symbolNum = length(symbol);
C = zeros(symbolNum^2,2); 
[x,y] = meshgrid(1:symbolNum,1:symbolNum);
index = [x(:),y(:)];

C(:,1) = symbol(index(:,1));
C(:,2) = symbol(index(:,2));

end

