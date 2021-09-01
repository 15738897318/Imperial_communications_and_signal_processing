clc
clear all
close all

% solve AR coefficients

syms r0 r1 r2;

K = [r0 r1 r2; r1 r0 r1; r2 r1 r0];
eqns = K * [1; 0.1; 0.8] == [0.25;0;0];
vars = [r0 r1 r2];

[r0,r1,r2] = solve(eqns, vars);
r0 = double(r0);
r1 = double(r1);
r2 = double(r2);

R = [r0 r1; r1 r0]
mu_max = 2/max(eig(R))
