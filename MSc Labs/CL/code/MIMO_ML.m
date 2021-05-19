function BER = MIMO_ML(SNR_dB,symbol_num, bit_seq, H, N, bit_symbol)
%% generate signal
n_all = sqrt(1/2) * (randn(symbol_num,2) + 1i*randn(symbol_num,2));
SNR = power(10,SNR_dB/10);
Y = QPSK_mod(bit_seq, symbol_num, H, N, n_all, SNR);
rec_bit_seq = zeros(N,symbol_num * bit_symbol);
%% maximum-likelihood (ML) detector
M = power(2,bit_symbol) * power(2,bit_symbol);
ps = zeros(N,bit_symbol,M);
i = 1;
% all possible results
for a = 0:1
for b = 0:1
for c = 0:1
for d = 0:1
    ps(:,:,i) = [a,b;c,d];
    i = i+1;
end 
end
end
end


for i = 1:symbol_num
    y = Y(:,i);
    d = zeros(1,M);
    for j = 1:M
        x_ = [QPSK_map(ps(1,1,j), ps(1,2,j)); QPSK_map(ps(2,1,j), ps(2,2,j))];
        d(j) = power(norm(y - sqrt(SNR / N) * H * x_), 2);
    end
    r = ps(:,:,d==min(d));
    rec_bit_seq(:, 2*i-1:2*i) = r;
end


%% calculate bit error rate
difference = bit_seq - rec_bit_seq;
err_num = sum(sum(difference ~= 0));
BER = err_num / (bit_symbol * symbol_num * N);
end