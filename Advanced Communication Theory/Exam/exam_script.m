clc
clear all
close all

%% Array Manifold
phi = 60;
array=[-0.5 0 0; 0.5 0 0];
S = exp(-1i*array*K(phi/180*pi,0));


%% Space time coding
s1 = -1/2;
s2 = -1i/2;
beta = [0.01*exp(1i*30/180*pi); 0.1*exp(1i*60/180*pi)];

x = [s1 -conj(s2); s2 conj(s1)] * beta;

x = [beta(1) -beta(2); conj(beta(2)) conj(beta(1))] * [s1; s2];



%% STAR
array=[-2 0 0; 0 0 0; 2 0 0;];

c = fMSeqGen([1;1;1]);
c = (1 - 2*c);
Nc = size(c,2);
Next = Nc * 2;

c = [c, zeros(1,Nc)];
c = c.';

J = [zeros(1, Next-1) 0;
     eye(Next-1) zeros(Next-1,1)];
 
S = exp(-1i*array*K(30*pi/180,0));
h = kron(S,(J^2 * c));


%% Beamwidth

lambda = 3e8 / 2.4e9;
d = lambda/2;
N = 100;
beamwidth = 2*asin(lambda / (N*d)) * 180/pi;

%% noise power at output of beamformer
sigma_2 = 1e-4;

w = [-0.1125+0.9936i, 0.6661+0.7458i, 1, 0.6661-0.7458i, -0.1125-0.9936i].';
pn = sigma_2 * (w' * w);

%% capacity
B = 8e3; % bandwidth
P = 100e-3;
N = 2*B * 1e-2;

capacity = B * log2(1+10*P/N);

%% Calculate Rmm
Rxx = [10.2040 - 0.0000i  -0.5788 + 4.1396i   6.7444 - 4.5482i   4.5234 + 6.4366i   1.2585 - 4.0588i;
  -0.5788 - 4.1396i   7.2210 + 0.0000i  -1.7454 + 0.1726i   5.9678 - 4.3653i   1.4498 + 3.4004i;
   6.7444 + 4.5482i  -1.7454 - 0.1726i   8.0986 + 0.0000i  -0.6623 + 4.4220i   4.8585 - 3.4939i;
   4.5234 - 6.4366i   5.9678 + 4.3653i  -0.6623 - 4.4220i   9.5774 + 0.0000i  -1.5253 + 1.1245i;
   1.2585 + 4.0588i   1.4498 - 3.4004i   4.8585 + 3.4939i  -1.5253 - 1.1245i   6.5210 + 0.0000i];


array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
S1 = exp(-1i*array*K(30*pi/180,0));
S2 = exp(-1i*array*K(35*pi/180,0));
S3 = exp(-1i*array*K(90*pi/180,0));

S = [S1 S2 S3];
S_inverse = inv(S'*S)*S';

Rmm = S_inverse*(Rxx - 0.1*eye(size(Rxx)))*S_inverse';

%% array pattern
array=[-3 0 0; -2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0; 3 0 0];

w = exp(-1i*array*K(120*pi/180,0));
Z=arrayPattern(array,w,'Exam');
ylim([0 8])
xlim([0 360])

%% supperesolution beamforming
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0;];
S1 = exp(-1i*array*K(30*pi/180,0));
S2 = exp(-1i*array*K(50*pi/180,0));
S3 = exp(-1i*array*K(120*pi/180,0));

Sj = [S2 S3];

Pj = Sj * inv(Sj'*Sj) * Sj';
w = (eye(5) - Pj) * S1;
w = w ./ norm(w);

%% steering matrix
lambda = 3e8 / 2.4e9;
array = [-0.0938 0 0; -0.0313 0 0; 0.0313 0 0; 0.0938 0 0]; % in unit of meter
array = array ./ (lambda/2);

w = exp(-1i*array*K(30*pi/180,0));

%% Wiener-Hopf beamforming
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0;];
Rxx = [7.8000 - 0.0000i, -0.7327 + 2.1623i, 5.5846 - 3.7594i, 2.9266 + 4.3835i, 1.3609 - 3.8965i;
    -0.7327 - 2.1623i, 7.8000 + 0.0000i, -0.7327 + 2.1623i, 5.5846 - 3.7594i, 2.9266 + 4.3835i;
    5.5846 + 3.7594i, -0.7327 - 2.1623i, 7.8000 + 0.0000i, -0.7327 + 2.1623i, 5.5846 - 3.7594i;
    2.9266 - 4.3835i, 5.5846 + 3.7594i, -0.7327 - 2.1623i, 7.8000 - 0.0000i, -0.7327 + 2.1623i;
    1.3609 + 3.8965i, 2.9266 - 4.3835i, 5.5846 + 3.7594i, -0.7327 - 2.1623i, 7.8000 + 0.0000i;];

S = exp(-1i*array*K(30*pi/180,0));
w = inv(Rxx) * S;
w = w ./ norm(w);


%% rate of change of the arclength
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0;];
rx = array(:,1);
ry = array(:,2);

theta = 30/180*pi;
rate = pi * norm(-sin(theta) * rx + cos(theta) * ry);

%% array apeture
array=[-2 -0.5 0; 2 -0.5 0; 2 1 0; -2 0.5 0];

index = nchoosek(1:size(array,1), 2);

diff = array(index(:,1),:) - array(index(:,2),:);
apeture = max(sum(abs(diff).^2,2).^(1/2));


%% Virtual SIMO/MISO of MIMO
Tx = [0 -0.5 0; 0 0.5 0];
Nt = size(Tx,1);
Rx = [0 -2 0; 0 2 0];
Nr = size(Rx,1);
r_virtual = kron(Tx, ones(Nr,1)) + kron(ones(Nt,1), Rx)

%% signal power and SNR at output of beamformer
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0;];
S = exp(-1i*array*K(90*pi/180,0));
w = S;
% w = [-0.1125+0.9936i, 0.6661+0.7458i, 1, 0.6661-0.7458i, -0.1125-0.9936i].';
% S = [-0.1125+0.9936i, 0.6661+0.7458i, 1, 0.6661-0.7458i, -0.1125-0.9936i].';
P_in = 1;
sigma_2 = 0.1;

P_out = P_in * (w'*S)^2;
N_out = sigma_2 * w'*w;
SNR = P_out/N_out;


%% bit error rate

sigma = 1e-3;
syms d;
eqn = 1/2*erfc(d/(sqrt(2)*sigma)) == 0.006;

double(solve(eqn,d));




S1 = exp(-1i*array*K(30*pi/180,0));
S2 = exp(-1i*array*K(60*pi/180,0));
S3 = exp(-1i*array*K(90*pi/180,0));
S4 = exp(-1i*array*K(70*pi/180,0));

S = [S1, S2, S3, S4];

Rss = S * [1 0.4 0 0; 0.4 1 0 0; 0 0 1 1; 0 0 1 1] * S';

eig(Rss);


%% 

B = 16e3;
P = 100e-3;
sigma = 1e-2 * 2*B;

C = B*log2(1 + 10 * P / sigma);




