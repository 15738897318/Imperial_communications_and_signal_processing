clc 
clear all
close all
addpath('../CommonFunctions')

%% Images
img1 = imread('../Images/torres.jpg'); % desired image
img2 = imread('../Images/hazard.jpg');
img3 = imread('../Images/lampard.jpg');
[x1,y1,~] = size(img1);
[x2,y2,~] = size(img2);
[x3,y3,~] = size(img3);

fprintf('Three images for three users.\n');
figure();
subplot(3,1,1);
imshow(img1);
title('Original Desired Image (User 1);');  
subplot(3,1,2);
imshow(img2);
title('Interference Image (User 2)');  
subplot(3,1,3);
imshow(img3);
title('Interference Image (User 3)');

fprintf('Program paused. Press enter to continue.\n\n');
pause;

%% Image Sources
fprintf('Encoding the images to bit sequences.\n');

Q1 = x1*y1*3*8;
Q2 = x2*y2*3*8;
Q3 = x3*y3*3*8;
P = max([Q1,Q2,Q3]);
bitsOut_im1 = fImageSource('../Images/torres.jpg',P);
bitsOut_im2 = fImageSource('../Images/hazard.jpg',P);
bitsOut_im3 = fImageSource('../Images/lampard.jpg',P);

fprintf('Program paused. Press enter to continue.\n\n');
pause;

%% Modulation (DS-QPSK)
fprintf('DS-QPSK modulation.\n');

X = 23; % alphabetical order of the 1st letter of my surname (Wang)
Y = 26; % alphabetical order of the 1st letter of your formal first name (Zhaolin)

% genarate m sequences
coeff1 = [1,0,0,1,1];
coeff2 = [1,1,0,0,1];
mSeq1 = fMSeqGen(coeff1);
mSeq2 = fMSeqGen(coeff2);
% calculate shift delay of the sencond m seqence
d = 1+mod(X + Y,12);
success = 0;
% find a balanced gold sequence
while success == 0
    goldSeq1 = fGoldSeq(mSeq1, mSeq2, d); % gold sequence for first image
    goldSeq1_trans = (1 - 2*goldSeq1)'; 
    if sum(goldSeq1_trans) == -1
        success = 1;
    else
        d = d+1;
    end
end
goldSeq2 = fGoldSeq(mSeq1, mSeq2, d+1);% gold sequence for second image
goldSeq3 = fGoldSeq(mSeq1, mSeq2, d+2);% gold sequence for third image

% calculate the angle for QPSK modulation
phi = (X + 2*Y) * pi /180;
symbol = sqrt(2) * [cos(phi)+1i*sin(phi);cos(phi+pi/2)+1i*sin(phi+pi/2); 
                     cos(phi+pi)+ 1i*sin(phi+pi);cos(phi-pi/2)+1i*sin(phi-pi/2)];
x = real(symbol);
y = imag(symbol);
figure();
plot(x,y,'o');
text(x+0.05,y+0.05,{'00','01','11','10'},'FontSize',10);
grid on;
title('QPSK Constellation');axis square;xlabel('Re');ylabel('Im');
% DS-QPSK modulation of three sources
symbols_img1 = fDSQPSKModulator(bitsOut_im1, goldSeq1', phi);
symbols_img2 = fDSQPSKModulator(bitsOut_im2, goldSeq2', phi);
symbols_img3 = fDSQPSKModulator(bitsOut_im3, goldSeq3', phi);

fprintf('Program paused. Press enter to continue.\n\n');
pause;

%% Channel
fprintf('Transmitting through the channel.\n');

% channel parameters
delays = [5; 7; 12];
fadingCoeff = [0.4; 0.7; 0.2];
DOAs = [30,0; 90,0; 150,0];
paths = [1,1,1];

% antenna array
array = antennaArray(5, pi/6);
figure();
plot3(array(:,1),array(:,2),array(:,3),'or');
title('Locations of Receiving Antenna Array');grid on;xlabel('x');ylabel('y');zlabel('z');axis square;

SNR = 0;
fprintf(['SNR = ' num2str(SNR) 'dB\n']);
symbolsIn = [symbols_img1.';symbols_img2.';symbols_img3.'];
symbolsOut = fChannel(paths,symbolsIn,delays,fadingCoeff,DOAs,SNR,array).';

fprintf('Program paused. Press enter to continue.\n\n');
pause;

%% Decoupled Spatiatemporal Estimation and Detection
fprintf('Decoupled Spatiatemporal Receiver.\n');

[delay_estimate, DOA_estimate, symbols_beamform] = fChannelEstimationDecoupled(symbolsOut, array, 1, goldSeq1);
bitsOut = fDSQPSKDemodulator(symbols_beamform.', goldSeq1', phi,delay_estimate, fadingCoeff(1));
[~,BER_decouple] = biterr(bitsOut, bitsOut_im1);

figure();
fImageSink(bitsOut, Q1,x1,y1);
title({'Desired Image Received by Decoupled Receiver'; ['SNR=',num2str(SNR),'dB | ','BER=',num2str(BER_decouple)]});
fprintf('Program paused. Press enter to continue.\n\n');
pause;

%% STAR Estimation and Detection
fprintf('STAR Receiver.\n');

Next = 2*15;
symbols_extended = fVectorExtension(symbolsOut, Next);
[delaysEstimated, DOAEstimated] = fChannelEstimationSTAR(symbols_extended,array, goldSeq1');
bitsOut = fDSQPSKDemodulatorSTAR(symbols_extended,array, goldSeq1',phi,delaysEstimated,fadingCoeff(1:paths(1)),DOAEstimated);
[~,BER_STAR] = biterr(bitsOut, bitsOut_im1);

figure();
fImageSink(bitsOut, Q1,x1,y1);
title({'Desired Image Received by STAR Receiver'; ['SNR=',num2str(SNR),'dB | ','BER=',num2str(BER_decouple)]});




