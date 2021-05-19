function [BER] = ZFSICreceiver(symbolRec,symbolSent,bitSent,QPSKsymbol,H,Es)
%Zero forcing receiver for the space multiplexing in MIMO channel
%[BER] = ZFSICreceiver(symbolRec,symbolSent,bitSent,QPSKsymbol,H,Es)
%Inputs:
%   symbolRec: symbols received at the receiver
%   symbolSent: symbols sent at the transmitter
%   bitSent: bits sent at the transmitter
%   QPSKsymbol: the QPSK symbpls used for modulation
%   H: channel matrix
%   Es: transmitting power at the transmitter
%Outputs:
%   BER: the bit error rate
%Date: 14/02/2021
%Author: Zhaolin Wang

nt = size(H,2); % number of antenna at transmitter

bitRec = zeros(size(bitSent));
H_zeroing = H;
for i = 1:nt
    G = sqrt(nt/Es) * inv(H_zeroing'*H_zeroing)*H_zeroing'; % detector for zero forcing
    c = G(1,:)*symbolRec;
    bitRec(:,i) = fQPSKDemodulator(c.', QPSKsymbol);
    symbolRec = symbolRec-sqrt(Es/nt)*H(:,i)*symbolSent(i,:); % perfect cancellation
    H_zeroing = H(:,i+1:end);
end

[~,BER] = biterr(bitSent, bitRec);
end

