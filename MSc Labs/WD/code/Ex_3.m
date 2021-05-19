clc
clear all
close all
m = 128;
n = 256;
S = 3:3:63;
test_num = 500;
success_rate_OMP = zeros(1,size(S,2));
success_rate_SP = zeros(1,size(S,2));
success_rate_IHT = zeros(1,size(S,2));
%% OMP
for i = 1:size(S,2)
    i
    success_num_OMP = 0;
    success_num_SP = 0;
    success_num_IHT = 0;
    for j = 1:test_num
        A = randn(m,n);
        A = normc(A);
        spars_index = randsample(n,S(i));
        x = zeros(n,1);
        x(spars_index) = randn(S(i),1);
        y = A * x;
        x_OMP = OMP(A, y, S(i));
        x_SP = SP_basic(y, A, S(i));
        x_IHT = IHT(S(i), A, y);
%         x_IHT = IHT_Basic(y, A, S(i));
        
        % test success
        err_OMP = norm(x_OMP - x) / norm(x);
        err_SP = norm(x_SP - x) / norm(x);
        err_IHT = norm(x_IHT - x) / norm(x);
        if err_OMP < 1e-6
            success_num_OMP = success_num_OMP + 1;
        end
        
        if err_SP < 1e-6
            success_num_SP = success_num_SP + 1;
        end
        
        if err_IHT < 1e-6
            success_num_IHT = success_num_IHT + 1;
        end
    end
    success_rate_OMP(i) = success_num_OMP / test_num;
    success_rate_SP(i) = success_num_SP / test_num;
    success_rate_IHT(i) = success_num_IHT / test_num;
end

figure(1);
plot(S, success_rate_OMP,'-^');
grid on;
xlabel('S');
ylabel('Success Rate');

hold on;
plot(S, success_rate_SP,'-o');
plot(S, success_rate_IHT,'-*');

legend('OMP','SP','IHT');
