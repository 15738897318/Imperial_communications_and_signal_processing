function M=fpoc(A);
%complement projection operator of A
M=A*inv(A'*A)*A';
M=eye(size(M))-M;

