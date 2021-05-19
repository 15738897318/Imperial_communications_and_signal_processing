function [BER] = MLreceiver(symbolRec,bitSent,QPSKsymbol,H,codebook)
%ML receiver for the space multiplexing in MIMO channel
%[BER] = MLreceiver(symbolRec,bitSent,QPSKsymbol,H,codebook)
%Inputs:
%   symbolRec: symbols received at the receiver
%   bitSent: bits sent at the transmitter
%   QPSKsymbol: the QPSK symbpls used for modulation
%   H: channel matrix
%   codebook: the codebook containing all the possible codes
%Outputs:
%   BER: the bit error rate
%Date: 14/02/2021
%Author: Zhaolin Wang

nt = size(H,2); % number of antenna at transmitter
c_H = H * codebook; % codebook with channel knowledge
symbolRec_rep(:,1,:) = symbolRec;
symbolRec_rep = repmat(symbolRec_rep,[1,size(codebook,2),1]);
[~,index] = min(sum(abs(symbolRec_rep - c_H))); % find the min distance
index = index(:); % index of the symbol in the codebook
symbolDetected= codebook(:,index).'; % detected symbol

bitRec = zeros(size(bitSent));
for i = 1:nt
    [bitRec(:,i)] = fQPSKDemodulator(symbolDetected(:,i), QPSKsymbol); % QPSK demodulation
end
[~,BER] = biterr(bitSent, bitRec);
end

