function [BER] = ZFreceiver(symbolRec,bitSent,QPSKsymbol,H,Es)
%Zero forcing receiver for the space multiplexing in MIMO channel
%[BER] = ZFreceiver(symbolRec,bitSent,QPSKsymbol,H,Es)
%Inputs:
%   symbolRec: symbols received at the receiver
%   bitSent: bits sent at the transmitter
%   QPSKsymbol: the QPSK symbpls used for modulation
%   H: channel matrix
%   Es: transmitting power at the transmitter
%Outputs:
%   BER: the bit error rate
%Date: 14/02/2021
%Author: Zhaolin Wang

nt = size(H,2); % number of antenna at transmitter
G = sqrt(nt/Es) * inv(H'*H)*H'; % detector for zero forcing
symbolDetected = G * symbolRec;
symbolDetected = symbolDetected.';
bitRec = zeros(size(bitSent));
for i = 1:nt
    [bitRec(:,i)] = fQPSKDemodulator(symbolDetected(:,i), QPSKsymbol); % QPSK demodulation
end
[~,BER] = biterr(bitSent, bitRec);


end

