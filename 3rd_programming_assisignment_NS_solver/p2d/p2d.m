close all;
clear all;
clc;

n = 500;
h = 1 / (n+1);
itmax = 100;

b = zeros(n+1,1);
b(n+1,1) = 1;

u  = -2 * ones(n+1,1);
v  = ones(n,1);
A  = diag(v,-1) + diag(v,1) + diag(u,0);

y = ones(n+1,1);
x = linspace(0,1,n+1)';

for i = 1:itmax
    
    F = A * y + b - h^2 * (y.^2 - 1);
    J = A - h^2 * diag ( 2 * y );
    y = y - J \ F;
    
    res    = F;
    resmax = max ( abs ( res ) );
    
    if ( resmax < 1e-15 ) break
    end
    
end

plot ( x, y );
axis ([0,1,0,1]);
title('Solution y versus x - part d');
xlabel('x');
ylabel('y');