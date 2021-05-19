function result = QPSK_map(bit_1, bit_2)
result = sqrt(1/2) * ((-2*bit_1+1) + (-2*bit_2+1)*1i); % Gray coding
end