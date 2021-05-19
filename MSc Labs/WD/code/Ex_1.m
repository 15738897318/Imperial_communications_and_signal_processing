m = 128;
n = 256;
A = randn(m,n);
A = normc(A);

x = randn(n,1);
y = A * x;

x_1 = pinv(A)*y;
x_2 = A\y;

figure(1);
plot(x);
title('original x vector');
ylim([-9 9])
grid on;

figure(2);
plot(x_1);
title('pinv(A)*y');
ylim([-9 9])
grid on;

figure(3);
plot(x_2);
title('A\y');
ylim([-9 9])
grid on;
