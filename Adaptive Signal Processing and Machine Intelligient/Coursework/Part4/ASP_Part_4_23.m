clc
clear all
close all

load('./data/time-series.mat');

% remove mean
y = y - mean(y);

M = 4; % order of the model
mu = 10^(-5); % step size
N = length(y); % length of the signal
w = zeros(M,1); % initial weights

y_predict = zeros(length(y),1);
e_all = zeros(length(y),1);
alpha = 40;
for n = M+1:N
    x_n = flip(y(n-M:n-1));
    e_n = y(n) - alpha*tanh(w'*x_n);
    y_predict(n) = alpha*tanh(w'*x_n);
    w = w + mu * e_n * x_n; 
    
    e_all(n) = e_n;
end

% MSE and prediction gain
MSE = mean(e_all.^2);
sigma_y = mean(y_predict.^2) - mean(y_predict)^2;
sigma_e = mean(e_all.^2) - mean(e_all)^2;
Rp = 10*log10( sigma_y /  sigma_e);

fprintf('MSE is %.3f \n',MSE);
fprintf('Prediction gain is %.3f \n',Rp);



figure;
plot(y,'-b','LineWidth',1);
hold on;
plot(y_predict,'-r','LineWidth',1);
grid on;
xlabel('Sample $n$','FontSize',16,'interpreter','latex');
legend('Actual signal $y(n)$','Estimated signal $\hat{y}(n)$','FontSize',14);
set(legend,'Interpreter','latex');
ylim([-50,50]);