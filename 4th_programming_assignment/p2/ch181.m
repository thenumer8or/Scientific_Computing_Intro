%  Monte Carlo computation of area, algorith 18.1
%  generate random points in the square [0,R]*[0,R]
%  x^2 + y^2 <= R^2 is the condition for the random point to lie inside

clear all; close all; clc;

n     = [10, 100, 1000, 10000, 100000];
area  = zeros (2, length (n));
error = zeros (2, length (n));
R     = 0.5;

for k=1:length(n)
    
    count = 0;
    
    for i=1:n(k)
        x = rand / 2;
        y = rand / 2;
        if x^2 + y^2 <= R^2
            count = count + 1;
        end
    end
    
    area(1,k)  = ( count / n(k) ) * R^2;
    error(1,k) = abs((pi / 4) * R^2 - area(1,k));
    
end

% part (b): algorith 18.2 -------------------------------------------------

for k=1:length(n)
    
    sum = 0;
    
    for i=1:n(k)
        x = rand / 2;
        f = sqrt (R^2 - x^2);
        sum = sum + f;
    end
    
    area(2,k)  = ( sum / n(k) )* R;
    error(2,k) = abs ( (pi / 4) * R^2 - area(2,k) );
    
end

semilogx ( n, error(1,:), '-o', n, error(2,:), '-*' );
legend('Algorithm 18.1','Algorithm 18.2',2, 'location', 'NorthEast');
title('Error comparison of 2 algorithms'); xlabel('n'); ylabel('error');


