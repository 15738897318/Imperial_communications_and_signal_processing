function result = SP2(K, A, y)

%% initialization
S = supportH(A' * y, K);
y_r = resid(y, A(:,S));
e_pre = 100000;

%% The Subspace Pursuit (SP) Algorithm
while 1
    % step 1
    S_ = union(S, supportH(A' * y_r, K));
    
    % step 2
    A_S_ = A(:,S_);
    b = zeros(size(A,2),1);
    b(S_) = A_S_ \ y;
%     b = A_S_ \ y;
    
    
    % step 3
    S = supportH(b, K);
    
    % step 4
    y_r = resid(y,A(:,S));
     
    % exit criteria
    e = norm(y_r);
    if e >= e_pre
        break;
    end
    e_pre = e;
end

A_S = A(:,S);
x = zeros(size(A,2),1);
x(S) = A_S \ y;
result = x;
end