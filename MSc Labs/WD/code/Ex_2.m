clc
clear all

m = 128;
n = 256;
S = 12;

rng(5);
A = randn(m,n);
A = normc(A);
spars_index = randsample(n,S);
x = zeros(n,1);
x(spars_index) = randn(S,1);
y = A * x;

x_OMP = OMP(A, y, S);
x_SP = SP2(S, A, y);
x_pinv = pinv(A) * y;
x_ = A \ y;
x_IHT = IHT(S, A, y);
% x_IHT = IHT_Basic(y, A, S);
% x_IHT = hard_l0_Mterm(y, A, S);

figure(1);
subplot(1,3,1);
plot(x);
title('x_o_r_i_g_i_n_a_l');

% subplot(1,3,2);
% plot(x_OMP);
% title('x_O_M_P');
% 
% subplot(1,3,3);
% plot(x - x_OMP);
% title('difference');
% 
% norm(x_OMP - x) / norm(x)
% 
% subplot(1,3,2);
% plot(x_SP);
% title('x_S_P');
% 
% subplot(1,3,3);
% plot(x - x_SP);
% title('difference');
% 
% norm(x_SP - x) / norm(x)

subplot(1,3,2);
plot(x_IHT);
title('x_I_H_T');

subplot(1,3,3);
plot(x - x_IHT);
title('difference'); 
norm(x_IHT - x) / norm(x)

% subplot(1,3,2);
% plot(x_pinv);
% title('pinv(A) * y');
% 
% subplot(1,3,3);
% plot(x - x_pinv);
% title('difference');
% 
% norm(x_pinv - x) / norm(x)


% subplot(1,3,2);
% plot(x_);
% title('A\y');
% 
% subplot(1,3,3);
% plot(x - x_);
% title('difference');
% 
% norm(x_ - x) / norm(x)

