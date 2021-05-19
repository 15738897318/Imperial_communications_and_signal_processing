% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wavenumber vector in unit of half wavelength
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% theta = Azimuth angle in unit of radian
% phi = elevation angle in unit of radian
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% k (3x1 Double) = Wavenumber vector in unit of half wavelength
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function k = K(theta,phi)
k = pi * [cos(theta).*cos(phi), sin(theta).*cos(phi), sin(phi)]';
end

