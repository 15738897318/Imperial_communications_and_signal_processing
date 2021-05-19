function [s,sigma] = waterFilling(H,N0)
%WATERFILLING Summary of this function goes here
%   Detailed explanation goes here
[~,S,~] = svd(H);
sigma = sort(diag(S),'descend');
n = length(sigma);
for i = 1:n
    u = 1/(n-i+1) * (1 + sum(N0 ./ sigma(1:end-i+1).^2));
    s_ = u - N0 ./ sigma(1:end-i+1).^2;
    if s_(end) >=0 
        break
    end
end
s = zeros(length(sigma),1);
s(1:length(s_)) = s_;

% x = N0 ./ sigma(1:end-i+1).^2;
% bar(x+s);
% hold on;
% bar(x)

end

