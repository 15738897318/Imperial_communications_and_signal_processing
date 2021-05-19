clc
clear all
close all

addpath('../CommonFunctions')

load('ACT_CW_Part_A_FastFading.mat');
%% Gold Sequence of Desired User
coeff1 = [1,0,0,1,0,1];
coeff2 = [1,0,1,1,1,1];

mSeq1 = fMSeqGen(coeff1);
mSeq2 = fMSeqGen(coeff2);
goldSeq = fGoldSeq(mSeq1, mSeq2, phase_shift)';

%% STAR Channel Estimation & Reception
array = antennaArray(5, pi/6);
Nc = size(goldSeq,1);
Next = 2*Nc;
Xextended = fVectorExtension(Xmatrix, Next);
[delay_estimate, DOA_estimate] = fChannelEstimationSTAR(Xextended, array, goldSeq);
bitsOut = fDSQPSKDemodulatorSTAR(Xextended, array, goldSeq, phi_mod*pi/180,delay_estimate,Beta_1,DOA_estimate);

%% ASCII Decoding
bits = bitsOut(1:480);
bits = reshape(bits,8,60);
i = 0:7;
i = fliplr(i);
p = 2.^i;
c = char(p*bits);
fprintf([c '\n']);
