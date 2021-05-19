function [Lambda] = pathLoss_center(Q, user_loc)
%PATHLOSS_ALL Summary of this function goes here
%   Detailed explanation goes here

Lambda = zeros(Q,1);
centerBS_loc = [0,0];
for q = 1:Q
    user_loc_q = user_loc(q,:);
    d_infer = sum(abs(user_loc_q - centerBS_loc).^2,2).^(1/2) ./1000; % distance from interferers
    Lambda(q) = pathLoss(d_infer); % large scale fading for user q 
end
end

