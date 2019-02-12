clc;
clear all;
close all;

x0 = 0;
x1 = 1;
X  = [x0, x1];

N=1000;
kappa = linspace(0.1,1.5,N);

[kappastar] = kappasolver (kappa);

y0 = [0,(2*kappastar)^0.5]';
    
options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
[x,y] = ode45(@p2fun,X,y0,options);
    
plot ( x, y(:,1) );
axis ([x0,x1,0,1]);
title('Solution y versus x - part b');
xlabel('x');
ylabel('y');