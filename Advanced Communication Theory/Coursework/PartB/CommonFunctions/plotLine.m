% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/27

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot a hyperbola
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% o (3x1 Doubles) = A point on the line
% theta (Doubles) = Direction of the line in the unit of radian
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotLine(o,theta)
% the line along with the x-axis
x = -200:0.01:200;
y = zeros(size(x));

% rotate and shift the line
rotation = [cos(theta) -sin(theta); sin(theta) cos(theta)];
xy = [x;y];
xy = rotation * xy;
xy = xy+o';
c = 0.7*[1 1 1];
plot(xy(1,:), xy(2,:), 'Color',c);

end

