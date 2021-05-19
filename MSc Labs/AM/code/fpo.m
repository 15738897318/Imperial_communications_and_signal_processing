function M=fPO(A);
%finds the Projection operator of A
M=A*inv(A'*A)*A';