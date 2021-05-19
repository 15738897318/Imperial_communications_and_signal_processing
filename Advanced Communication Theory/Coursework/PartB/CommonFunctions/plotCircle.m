% Zhaolin Wang, CSP (EE4/MSc), 2020, Imperial College.
% 2020/12/27

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot a circle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% o (3x1 Doubles) = Center of circle
% r (Double) = Radius of circle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotCircle(o,r)
angle = 0:0.001:2*pi;
x = r*cos(angle) + o(1);
y = r*sin(angle) + o(2);
c = 0.7*[1 1 1];
plot(x,y,'Color',c);
end

