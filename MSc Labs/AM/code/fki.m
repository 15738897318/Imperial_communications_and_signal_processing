function KI=fki(az,el);
%wavenumber vector in half wavelengths;
KI = pi*[cos(az).*cos(el)   sin(az).*cos(el)    sin(el)]';
 