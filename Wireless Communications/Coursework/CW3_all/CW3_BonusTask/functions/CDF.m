function [cdf,range] = CDF(x,step)
%Calculate the CDF of the data
%  [cdf,range] = CDF(x,step)
%Inputs:
%   x: data
%   step: the distance between two data points
%Outputs:
%   cdf: CDF of the data
%   range: range of the CDF
%Date: 28/02/2021
%Author: Zhaolin Wang

range = min(x) :step: max(x);
cdf = zeros(length(range),1);
for i = 1:length(range)
    cdf(i) = length(x(x<range(i))) / length(x) * 100;
end
end

