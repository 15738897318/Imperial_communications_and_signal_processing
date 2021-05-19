% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/24

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perform demodulation of the received data using STAR receiver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% symbolsIn (Fx1 Integers) = R channel symbol chips received
% array (Nx3 Doubles) = Array locations in half unit wavelength
% goldseq (Wx1 Integers) = W bits of 1's and 0's representing the gold
% sequence of the desired signal to be used in the demodulation process
% phi (Integer) = Angle index in degrees of the QPSK constellation points
% delays (Integer) = Vector of the estimated delays of desired user
% betas (Complex) = Vector of the fadding coefficient of desired user
% DOAs (Double) = Vector of the directions of arrival of desired user in
% the form [Azimuth, Elevation]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% bitsOut (Px1 Integers) = P demodulated bits of 1's and 0's
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [bitsOut] = fDSQPSKDemodulatorSTAR(symbolsIn,array,goldSeq,phi,delays,betas,DOAs)

M = size(delays,1); % number of multipaths
Nc = size(goldSeq,1);
Next = 2*Nc;
%% Spatiotemporal Beamforming
% Shitfing Matrix
J = [zeros(1, Next-1) 0;
     eye(Next-1) zeros(Next-1,1)];
goldSeq = (1 - 2*goldSeq);
Nc = size(goldSeq,1);
c = [goldSeq' zeros(1,Nc)]'; % padding gold sequence with zeros
H = [];
for i = 1:M
    d = delays(i);
    DOA = DOAs(i,:);
    S = exp(-1i*array*K(DOA(1)*pi/180,DOA(2)*pi/180)); % array manifold vector
    h = kron(S,(J^d * c)); % extended manifold vector
    H = [H h];
end
w = H*betas; % beamformer

% STAR array pattern
Z = arrayPatternSTAR(array,w,J,c,'Array pattern of Spatiotemporal beamformer');
s_receive = w'*symbolsIn;

%% QPSK Demodulation
x = real(s_receive);
y = imag(s_receive);
figure();
plot(x,y,'o');grid on;xlabel('Re');ylabel('Im');title('Constellation of Received Symbols (STAR Receiver)');
axis square;

L_despread = size(s_receive,2);
symbols = sqrt(2) * [cos(phi)+1i*sin(phi);cos(phi+pi/2)+1i*sin(phi+pi/2); 
                     cos(phi+pi)+ 1i*sin(phi+pi);cos(phi-pi/2)+1i*sin(phi-pi/2)];
map = [0 0; 0 1; 1 1; 1 0]'; % map from QPSK symbols to bits
s_receive = repmat(s_receive,4,1);
distance = abs(s_receive-symbols);
[row,~] = find(distance == min(distance)); % find the minimum distance
bitsOut = zeros(L_despread*2, 1);
for i = 1:size(row,1)
    bitsOut(2*i-1:2*i) = map(:,row(i));
end

end

