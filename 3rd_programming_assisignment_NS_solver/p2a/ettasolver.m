function [ettastar, xfin, yfin] = ettasolver (X, N, etta)

ettastar = etta(1);

for i=1:N
    
    y0 = [0,etta(i)]';
    
    options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4]);
    [x,y] = ode45(@p2fun,X,y0,options);
    
    y1minetta(i) = y (length(y),1) - 1;
    
    if ( abs(y1minetta(i)) < 10^-3 )
        ettastar = etta(i);
        [xfin,yfin] = ode45(@p2fun,X,y0,options);
    end
    
end

