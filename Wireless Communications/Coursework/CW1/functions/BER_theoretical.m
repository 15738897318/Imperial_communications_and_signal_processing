% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2021/01/28

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the theorecical Bit Error Rate (BER) in the cases of SISO, SIMO
% with MRC, MISO with MRT, and MISO with Alamouti scheme
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% N (Integer) = Number of antennas
% SNR_dB (1xK Doubles) = K Signal Noise Ratio (SNR) in dB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% BER_siso (1xK Double) = Theoretical BER in SISO case
% BER_simo (1xK Double) = Theoretical BER in SIMO case with MRC
% BER_miso_mrt (1xK Double) = Theoretical BER in MISO case with MRT
% BER_miso_alamouti (1xK Double) = Theoretical BER in MISO case with Alamouti scheme
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [BER_siso, BER_simo, BER_miso_mrt, BER_miso_alamouti] = BER_theoretical(N, SNR_dB)

dmin = sqrt(2); % minimum distance of the separation of the normalized constellation

BER_simo = [];
BER_siso = [];
BER_miso_mrt = [];
BER_miso_alamouti = [];

for i=1:size(SNR_dB,2)

    snr = 10.^(SNR_dB(i)./10);
    % BER in SISO
    fun_siso = @(u) qfunc(sqrt(snr.*u./2) .* dmin) .* exp(-u); 
    BER_siso = [BER_siso, integral(fun_siso, 0, Inf)];
    
    % BER in SIMO with MRC
    fun_simo = @(u) qfunc(sqrt(snr.*u./2) .* dmin) .* 1./factorial(N-1) .* u.^(N-1) .* exp(-u); 
    BER_simo = [BER_simo, integral(fun_simo, 0, Inf)];
    
    % BER in MISO with MRT
    fun_miso_mrt = @(u) qfunc(sqrt(snr.*u./2) .* dmin) .* 1./factorial(N-1) .* u.^(N-1) .* exp(-u);
    BER_miso_mrt = [BER_miso_mrt, integral(fun_miso_mrt, 0, Inf)];
    
    % BER in MISO with Alamouti scheme
    fun_miso_alamouti = @(u) qfunc(sqrt(snr.*u./4) .* dmin) .* 1./factorial(N-1) .* u.^(N-1) .* exp(-u);
    BER_miso_alamouti = [BER_miso_alamouti, integral(fun_miso_alamouti, 0, Inf)];
    
end


end

