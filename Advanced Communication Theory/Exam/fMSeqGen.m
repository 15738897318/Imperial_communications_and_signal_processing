% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Takes polynomial weights and produces an M-Sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% coeffs (Px1 Integers) = Polynomial coefficients. For example, if the
% polynomial is D^5+D^3+D^1+1 then the coeffs vector will be [1;0;1;0;1;1]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% MSeq (Wx1 Integers) = W bits of 1's and 0's
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [MSeq]=fMSeqGen(coeffs)

% m sequence generator
if size(coeffs,1) < size(coeffs,2)
    coeffs = coeffs';
end

%% initilization
m = size(coeffs,1)-1; % number of shift registers
Nc = 2.^m - 1; % period of m sequence
statues = ones(1,m); % initial statues of shift registers
MSeq = zeros(1, Nc);

%% generating the m sequence
for step = 1:Nc
    first = mod(statues * coeffs(2:end),2);
    statues(2:end) = statues(1:end-1);
    statues(1) = first;
    MSeq(step) = statues(end); % o/p is the statue of the last register
end

% %% transfer to +1/-1
% MSeq = (1 - 2*MSeq)';

end