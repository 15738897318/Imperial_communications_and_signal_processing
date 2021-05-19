function result  = IHT(S, A, y)

%% initialization
x = zeros(size(A,2),1);
e_pre = 1000000;
% errs = zeros(1,20);
i = 1;
%% The Iterative Hardthresholding (IHT) Algor
while 1
    xx = x + A'* (y-A*x);
    x = zeros(size(A,2),1);
    s = supportH(xx, S);
    x(s) = xx(s);
    
    y_r = y - A * x;
    
    % exit criteria
    e = norm(y_r);
    if i == 1
        e_pre = e;
        i = 0;
    else
        if e >= e_pre
            break;
        end
        e_pre = e;
    end
    
    
%     if i > 20
%         break;
%     end
%     errs(i) = e;
%     i = i + 1;
end

% plot(1:20, log10(errs));
% xlabel('Iteration Steps');
% ylabel('log_1_0(Error)');
result = x;

end