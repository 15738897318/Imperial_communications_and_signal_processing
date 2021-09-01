clc
clear all
close all

load('./data/PCAPCR.mat');

%% Ordinary Least Squares
B_OLS = inv(Xnoise' * Xnoise)*Xnoise'*Y;
Y_OLS = Xnoise*B_OLS;

%% Principal Component Regression
[Unoise, Snoise, Vnoise] = svd(Xnoise);

rank = 3;
Xdenoise = Unoise(:,1:rank) * Snoise(1:rank, 1:rank) * Vnoise(:,1:rank)';
B_PCR = Vnoise(:,1:rank) * Snoise(1:rank, 1:rank)^(-1) * Unoise(:,1:rank)' * Y;
Y_PCR = Xdenoise*B_PCR;

%% Error on training set
error_OLS= mean(mean((Y-Y_OLS).^2));
error_PCR= mean(mean((Y-Y_PCR).^2));
fprintf(['The MSE of OLS method on training set is ' num2str(error_OLS) '\n']);
fprintf(['The MSE of PCR method on training set is ' num2str(error_PCR) '\n\n']);

%% Error on testing set
[Utest, Stest, Vtest] = svd(Xtest);
rank = 3;
Xdenoise_test = Utest(:,1:rank) * Stest(1:rank, 1:rank) * Vtest(:,1:rank)';

Y_OLS_test = Xtest*B_OLS;
Y_PCR_test = Xdenoise_test*B_PCR;

error_OLS_test= mean(mean((Ytest-Y_OLS_test).^2));
error_PCR_test= mean(mean((Ytest-Y_PCR_test).^2));
fprintf(['The MSE of OLS method on testing set is ' num2str(error_OLS_test) '\n']);
fprintf(['The MSE of PCR method on testing set is ' num2str(error_PCR_test) '\n\n']);

%% Performance on extar testing set
times = 1000;
error_OLS = 0;
error_PCR = 0;
for i = 1:times
    [Y_OLS, Y] = regval(B_OLS);
    error_OLS = error_OLS + mean(mean((Y-Y_OLS).^2));

    [Y_PCR, Y] = regval(B_PCR);
    error_PCR = error_PCR + mean(mean((Y-Y_PCR).^2));
end
error_OLS = error_OLS / times;
error_PCR = error_PCR / times;

fprintf(['The average MSE of OLS method on ' num2str(times) ' testing sets is ' num2str(error_OLS) '\n']);
fprintf(['The average MSE of PCR method on ' num2str(times) ' testing sets is ' num2str(error_PCR) '\n\n']);



