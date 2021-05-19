function [path_loss] = pathLoss(d)
%Calculate the path loss and shadowing
%   [path_loss] = pathLoss(d)
%Inputs:
%   d: distance in km
%Outputs:
%   path_loss: pass loss and shadowing
%Date: 27/02/2021
%Author: Zhaolin Wang

shadowing = 10^(16/10);
path_loss_dB = 128.1 + 37.6*log10(d);
path_loss = 10.^(path_loss_dB/10) * shadowing;

end

