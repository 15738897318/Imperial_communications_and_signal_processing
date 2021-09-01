clc
clear all
close all

addpath('./functions/');
fontsize = 13;
M = 5;

mu = 0.01;
num = 1000;
n = 1:1000;

M_all = [5, 10, 15, 20];
delta_all = 3:25;
MSPE_all = zeros(length(delta_all), length(M_all));

e_ave = zeros(length(n),1);

for m = 1:length(M_all)
    M = M_all(m);
    for d = 1:length(delta_all)
       delta = delta_all(d);
       
       x_hat_ave = zeros(length(n),1);
       for k = 1:num
            % pure signal
            x = sin(0.01*pi*n');

            % MA noise
            eta = zeros(length(n)+2,1);
            wgn = randn(length(n)+2,1);
            for i = 3:length(eta)

               eta(i) = wgn(i) +  0.5*wgn(i-2);
            end
            eta = eta(3:end);

            % noisy signal
            s = x + eta;

            % Adaptive Line Enhancer
            w = zeros(M,1);
            x_hat_all = zeros(length(n),1);
            e_all = zeros(length(n),1);
            for i = (M+delta):length(n)
                u = flip(s(i-delta-M+1:i-delta));
                x_hat = w' * u;
                e = s(i) - x_hat;
                w = w + mu * e * u;
                
                % buffering
                e_all(i) = e;
                x_hat_all(i) = x_hat;
            end

            e_ave = e_ave + e_all;
            x_hat_ave = x_hat_ave + x_hat_all;
        end

        e_ave = e_ave ./num;
        x_hat_ave = x_hat_ave./num;

%         x_hat_ave = x_hat_ave(delta+M:end);
%         x = x(M:end-delta);
        MSPE = mean((x(M:end-delta) - x_hat_ave(delta+M:end)).^2);
        MSPE_all(d,m) = MSPE;
       
    end
end


% Plotting
figure;
for i = 1:length(M_all)
    M = M_all(i);
    plot(delta_all, MSPE_all(:,i),'LineWidth',1.5);
    hold on;    
end
legend('$M$ = 5','$M$ = 10','$M$ = 15','$M$ = 20','FontSize',fontsize,'interpreter','latex');
grid on;
xlabel('Delay $\Delta$','FontSize',fontsize,'interpreter','latex');
ylabel('MSPE','FontSize',fontsize,'interpreter','latex');
xlim([3,25]);




