function result = OMP(A, y, K)
%% intialization
y_r = y;
S = [];
e_pre = 100000;

%% The Orthogonal Matching Pursuit (OMP) Algorith
for i = 1:K
    % Step 1
    H_1 = supportH(A' * y_r, 1);
    S = union(S, H_1);
    
    % Step 2
    A_S = A(:,S);
    x = zeros(size(A,2),1);
    x(S) = A_S \ y;
    
    % Step 3
    y_r = y - A * x;
    
    % exit criteria
    e = norm(y_r);
    if e >= e_pre
        break;
    end
    e_pre = e;
end

result = x;

end