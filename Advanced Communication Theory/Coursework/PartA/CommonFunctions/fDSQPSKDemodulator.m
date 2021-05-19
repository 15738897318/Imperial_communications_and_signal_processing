% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/21

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perform demodulation of the received data using RAKE receiver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% symbolsIn (NxL Integers) = L channel symbol chips received. If the
% multipaths are not separated by the space beamformer, N=1;
% goldSeq (Ncx1 Integers) = Nc bits of 1's and 0's representing the gold
% sequence of the desired signal to be used in the demodulation process
% phi (Integer) = Angle index in degrees of the QPSK constellation points
% delays (Integer) = Vector of the estimated delays of desired user
% betas (Complex) = Vector of the fadding coefficient of desired user
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% bitsOut (Px1 Integers) = P demodulated bits of 1's and 0's
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [bitsOut]=fDSQPSKDemodulator(symbolsIn,goldSeq,phi,delays, betas)

%% DSSS despreader
M = size(delays,1); % number of multipaths
N = size(goldSeq,1); % length of gold seq.
L = size(symbolsIn,1); % length of sequence
k = floor(L/N);
goldSeq = (1 - 2*goldSeq);
symbolDespread = [];
% seperate the difference paths of desired signal
for i = 1:M
    d = delays(i);
    sta = 1+d;
    en = k*N+d;
    if size(symbolsIn,2) == 1
        % In this case, there is only one antenna, the multipaths cannot be
        % seperated according to the DOAs
        symbols = symbolsIn(sta:en,1);
    else
        % In this case, the multipaths have been seperated accroding DOAs
        symbols = symbolsIn(sta:en,i);
    end
    symbols = reshape(symbols,N,k);
    symbolDespread = [symbolDespread;goldSeq' * symbols];
end

% Max Ratio Combination
symbolDespread = conj(betas) * symbolDespread;

%% QPSK demodulation (ML detection)
x = real(symbolDespread);
y = imag(symbolDespread);
figure();
plot(x,y,'o');grid on;xlabel('Re');ylabel('Im');title('Constellation of Received Symbols (RAKE Receiver)');
axis square;

L_despread = size(symbolDespread,2);
symbols = sqrt(2) * [cos(phi)+1i*sin(phi);cos(phi+pi/2)+1i*sin(phi+pi/2); 
                     cos(phi+pi)+ 1i*sin(phi+pi);cos(phi-pi/2)+1i*sin(phi-pi/2)];
map = [0 0; 0 1; 1 1; 1 0]';% map from QPSK symbols to bits
symbolDespread = repmat(symbolDespread,4,1);
distance = abs(symbolDespread-symbols);
[row,~] = find(distance == min(distance));% find the minimum distance
bitsOut = zeros(L_despread*2, 1);
for i = 1:size(row,1)
    bitsOut(2*i-1:2*i) = map(:,row(i));
end
end