function [user_loc] = locationGen(Q)
%Generate the user locations
%   [user_loc] = locationGen(K)
%Inputs:
%   Q: number of users
%Outputs:
%   user_loc: locations of users
%Date: 27/02/2021
%Author: Zhaolin Wang

user_loc = (rand(Q,1)*(250-35) + 35) .* exp(1i * rand(Q,1)*2*pi); 
user_loc = [real(user_loc) imag(user_loc)];
end

