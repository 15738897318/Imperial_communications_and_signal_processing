% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/27

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot a hyperbola
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% c1 (3x1 Doubles) = First focus of hyperbola
% c2 (3x1 Doubles) = Second focus of hyperbola
% d (Doubles) = Distance difference of a point on the hyperbola and the two
% focus. Assume the distance with the focus c1 is d1 and that with the
% focus c2 is d2, then d = d1-d2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotHyperbola(c1,c2,d)
o = (c1+c2) / 2; % new coordinate origin
c = norm(c1-c2)/2;
a = d/2;
b = sqrt(c^2-a^2);

y = -100:0.01:100;
if d > 0
    x = -a * sqrt(1+y.^2/b^2); 
else
    x = a * sqrt(1+y.^2/b^2);
end

xy = [x;y];
c1c2 = c2-c1;
theta = atan(c1c2(2)/c1c2(1)); % direction of the new x-axis

rotation = [cos(theta) -sin(theta); sin(theta) cos(theta)]; % rotation matrix
xy = rotation * xy; % rotate the hyperbola
xy = xy+o'; % transform to the new coordinate origin 
c = 0.7*[1 1 1];
plot(xy(1,:),xy(2,:),'Color',c);
end

