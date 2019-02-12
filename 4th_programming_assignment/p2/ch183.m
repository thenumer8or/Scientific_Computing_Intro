clear all
close all
clc;

n  = 10;
R  = 0.5;
dx = R / n;

N  = [10, 100, 1000, 10000, 100000, 1000000];

error = zeros ( length(N), 1 );
app   = zeros ( length(N), 1 );
area  = zeros ( length(N), 1 );

for k = 1:length(N)
    
    X  = R * rand ( N(k), 1 );
    func = zeros ( N(k), 1 );
    
    for i = 1:n
        x(i) = dx * ( i - 1/2 );
        phat(i) = sqrt ( R^2 - x(i)^2);
        y(i) = dx * i;
    end
    
    Ip = sum ( dx * phat );
    p  = phat / Ip;
    
    for l = 1:(length(x)-1);
        j = find ( X < y(l+1) & X >= y(l) );
        func(j) = p(l+1);
    end
    
    jj = find ( X < y(1) );
    func(jj) = p(1);
    
    fvalue    = sqrt ( R^2 - X.^2 );
    app (k,1)   = mean ( fvalue ./ func );
    area (k,1)  = ( pi / 4 ) * R^2;
    error (k,1) = abs ( area(k,1) - app(k,1) );
    
end

semilogx (N, error, '-*')
title('Error of importance sampling algorithm for n=10 intervals');
xlabel('N');
ylabel('error');