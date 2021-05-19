clc
clear all
close all

p = 1/3;
results = walk(p);
plot(results);
grid on;
ylim([0,max(results) + 3]);
xlabel('t');
ylabel('x(t)');
title(['Random Walk with Left Barrier (p=1/3)'] )

function results = walk(p)
state = 0;
t = 1:10000;
results = zeros(size(t));
for i = 1:size(t,2)
    if state == 0
        state = state + 1;
    else
        r = rand();
        if r <= p
            state = state + 1;
        else
            state = state - 1;
        end
    end 
    results(i) = state;
end
end