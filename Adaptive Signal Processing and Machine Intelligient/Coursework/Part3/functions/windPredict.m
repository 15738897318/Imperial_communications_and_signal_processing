function [Rp_CLMS,Rp_ACLMS] = windPredict(v,mu)
%windPredict Perform one step predicion of wind
%[Rp_CLMS,Rp_ACLMS] = windPredict(v,mu)
%Inputs:
%   v: complex wind signal
%   mu: step size
%Outputs:
%   Rp_CLMS: prediction gain of CLMS
%   Rp_ACLMS: prediction gain of ACLMS
%Date: 18/03/2021
%Author: Zhaolin Wang

Rp_CLMS = [];
Rp_ACLMS = [];
for M = 1:10
    h = zeros(M,1);
    [e_CLMS,~] = CLMS(v,v,M,mu,h);
    Rp_CLMS = [Rp_CLMS mean(abs(v(M:end)).^2) / mean(abs(e_CLMS).^2)];

    h = zeros(M,1);
    g = zeros(M,1);
    [e_ACLMS,~] = ACLMS(v,v,M,mu,h,g);
    Rp_ACLMS = [Rp_ACLMS mean(abs(v(M:end)).^2) / mean(abs(e_ACLMS).^2)];
    
end
end

