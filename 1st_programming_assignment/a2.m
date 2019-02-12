clear all;
close all;
clc;

m = 200;
A = 2*eye(m) + 0.5*randn(m) / sqrt(m);

eigens   = eig(A);
realpart = real(eigens);
imagpart = imag(eigens);

figure
subplot (2,2,3);
plot (realpart,imagpart,'k*');
title  ('Eigenvalues of A in complex plane');

itmax = 30;
b = ones(m,1);
resnorm = ones(itmax,1);

for i = 1:itmax
    X   = GMRES(A,b,200,1e-16,i);
    res = A*X - b;
    resnorm(i) = norm(res,inf);
end

slope = ( log(resnorm(24)) - log(resnorm(3)) )/(24-3)

subplot (2,2,4);
semilogy (resnorm);
title  ('residual against interation number for GMRES');
xlabel ('numbre of iterations');
ylabel ('residual');