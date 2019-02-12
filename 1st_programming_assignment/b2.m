clear all;
close all;
clc;

m = 200;
for k = 1:m
    theta(k) = k*pi / (m-1);
    v(k) = (-2+2*sin(theta(k))) + i*cos(theta(k)); 
end

D = zeros(m,m);
D = diag(v);
B = 2*eye(m) + 0.5*randn(m) / sqrt(m) + D;
realpart = real(eig(B));
imagpart = imag(eig(B));

figure
subplot (2,2,3);
plot (realpart,imagpart,'k*');
title  ('Eigenvalues of B in complex plane');

itmax = 40;
b = ones(m,1);
resnorm = ones(itmax,1);
for i = 1:itmax
    X   = GMRES(B,b,200,1e-16,i);
    res = B*X - b;
    resnorm(i) = norm(res,inf);
end

slope = ( log(resnorm(40)) - log(resnorm(3)) )/(40-3)

subplot (2,2,4);
semilogy (resnorm);
title  ('residual against interation number for GMRES');
xlabel ('numbre of iterations');
ylabel ('residual');