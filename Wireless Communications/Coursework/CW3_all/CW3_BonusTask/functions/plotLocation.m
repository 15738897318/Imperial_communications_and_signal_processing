function plotLocation(user_loc,interferer_loc)
%Plot a the location of the users and BSs
%   plotLocation(user_loc,interferer_loc)
%Inputs:
%   user_loc: locations of the users
%   interferer_loc: locations of the interferers
%Outputs:
%   None
%Date: 27/12/2020
%Author: Zhaolin Wang

figure;
plot(interferer_loc(:,1),interferer_loc(:,2),'ok','LineWidth',3);
hold on;
plot(0,0,'or','LineWidth',3);
plot(user_loc(:,1),user_loc(:,2),'*b','LineWidth',1);
plotCircle([0,0],35);
plotCircle([0,0],250);
plotCircle([0,0],500);
legend('random interferer','center BS','user');
xlim([-700,700]);
ylim([-700,700])
axis square;
grid on;
end

