clear all;
clc;
close all;

N=10;
x=0.5;
y=0.5;
g = zeros (1,N);

for i=1:N
    g(i) = pe(x,y,i);
end

plot (g)