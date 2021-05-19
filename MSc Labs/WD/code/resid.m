function y_r  = resid(y, A)

y_p = A * (A'*A)^-1 * A' * y;
y_r = y - y_p;

end