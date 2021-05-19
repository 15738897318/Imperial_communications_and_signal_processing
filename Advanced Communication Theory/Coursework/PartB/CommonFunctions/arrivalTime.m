function t_arrival = arrivalTime(x,str)
x_power = abs(x);
L = size(x,2);
M = zeros(1,L);

for i = 1:L
%     M(i) =  (max(x_power(1:i)) + min(x_power(1:i)))/2;
    M(i) =  max(x_power(1:i));  
end

kernal = [0,1,-1]; % 1st derivative
N = conv(M,kernal,'same');
N = N(1:L-1);
threshold = (max(N)+min(N))/2;
N(N<threshold) = 0;
plot(N);
grid on;xlabel('nTs');

for i = 1:L-1
    if N(i) > 0
        break;
    end
end
t_arrival = i;
text(i,N(i),str,'FontSize',12);

end

