% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/21

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Achieve signal extension for STAR receiver using tapped delayed line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% signal (NxL Integers) = L symbol chips received at N antennas
% Next (Integer) = Length of tapped delayed line (Next = 2*Nc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% extented_signal ((Next*N)x(L/Nc) Complex) = Extended symbol sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function extented_signal = fVectorExtension(signal, Next)
% Extend the signal vector for STAR receivers
Nc = Next/2;
[N, L] = size(signal);
finish = 0;
i = 0;
extented_signal = [];
% Tapped Delayed Line
while finish == 0
    st = 1+i*Nc;
    en = Next+i*Nc;
    if en <= L
        X = signal(:,st:en); 
    else
        X = zeros(N, Next);
        X(:,1:L-st+1) = signal(:,st:end);
        finish = 1;
    end
    i = i + 1;
    X = reshape(X.',[N*Next,1]); 
    extented_signal = [extented_signal X];
end

end

