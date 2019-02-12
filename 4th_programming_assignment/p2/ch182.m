clear all; close all; clc;

n     = [10, 100, 1000, 10000, 100000, 1000000];
R     = 1; vol   = zeros (1, length(n)); error = zeros (1, length(n));

for k = 1:length(n)
    
    count = 0;
    for i = 1:n(k)
        
        x = 2 * rand - R; y = 2 * rand - R; z = 2 * rand - R;
        if x^2 + y^2 + z^2 <= R^2
            count = count + 1;
        end
        
    end
    vol(k)   = ( count / n(k) ) * (2 * R)^3;
    error(k) = abs ( (4 * pi / 3) * R^3 - vol(k) );
    
end

semilogx ( n, error, '-*' );
title('Error vs n'); xlabel('n'); ylabel('error');