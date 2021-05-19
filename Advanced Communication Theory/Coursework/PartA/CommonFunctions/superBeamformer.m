% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/23

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performing superresolution beamforming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% array (Nx3 Doubles) = Array locations in half unit wavelength
% directions = Vectors of DOAs of desired user
% desired = Vectors of the number of desired paths. For example, the
% estimated DOAs are sorted from small to large. If the desired paths are
% associated with the first and the third DOAs in the sorted estimated
% DOAs, the value of deisred should be [1,3].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% wsuper (Nx1 Complex) = Weights of superresolution beamformer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function wsuper = superBeamformer(array,directions, desired)

k = K(directions(:,1)*pi/180, directions(:,2)*pi/180);
S = exp(-1i*array*k);
Sd = S(:,desired); % DOA of desired signal

S_J = S;
S_J(:,desired) = [];% DOA of jammer signal

P_J = S_J*inv(S_J'*S_J)*S_J';
P_J_orth = eye(size(P_J))-P_J;

wsuper = P_J_orth*Sd;
end

