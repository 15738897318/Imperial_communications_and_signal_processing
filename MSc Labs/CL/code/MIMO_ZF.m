function BER = MIMO_ZF(SNR_dB,symbol_num, bit_seq, H, N, bit_symbol)
%% generate signal
n_all = sqrt(1/2) * (randn(symbol_num,2) + 1i*randn(symbol_num,2));
SNR = power(10,SNR_dB/10);
Y = QPSK_mod(bit_seq, symbol_num, H, N, n_all, SNR);
rec_bit_seq = zeros(N,symbol_num * bit_symbol);
%% zero-forcing detector
for i = 1:symbol_num
    y = Y(:,i);
    x_ = (sqrt(SNR / N) * H)^-1 * y;
    rec_bit_seq(1, 2*i-1:2*i) = QPSK_demap(x_(1));
    rec_bit_seq(2, 2*i-1:2*i) = QPSK_demap(x_(2));
end
%% calculate bit error rate
difference = bit_seq - rec_bit_seq;
err_num = sum(sum(difference ~= 0));
BER = err_num / (bit_symbol * symbol_num * N);

end