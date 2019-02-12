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
    
    rhs = h^2 * (y.^2 - 1) - b;
    y = A \ rhs;
    
    res = A * y - ( h^2 * (y.^2 - 1) - b );
    resmax = max ( abs ( res ) );
    
    if ( resmax < 1e-15 ) break
    end
    
end

plot ( x, y );
axis ([0,1,0,1]);
title('Solution y versus x - part c');
xlabel('x');
ylabel('y');