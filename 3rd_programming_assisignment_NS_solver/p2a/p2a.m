clc;
clear all;
close all;

x0 = 0;
x1 = 1;
X  = [x0, x1];

N=100;
etta = linspace(0,2,N);

[ettastar, xfin, yfin] = ettasolver (X, N, etta);


plot ( xfin, yfin(:,1) );
axis ([x0,x1,0,1]);
title('Solution y versus x - part a');
xlabel('x');
ylabel('y');