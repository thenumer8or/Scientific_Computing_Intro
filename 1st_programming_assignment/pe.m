function pe = exact(x,y,N)
pe = 0;
for i = 1:N
    pe = pe + 2*i*sin(i*pi*y)*sinh(i*pi*(1-x))/(pi*(i^2-1/4)*sinh(i*pi));
end
