function [kappastar] = kappasolver (kappa)

kappastar = kappa(1);
g = zeros (1, length(kappa));

for i=1:length(kappa)

    h = inline('1 ./ sqrt ( 2 * (k + y.^3/3 - y ) )');
    
    g(i) = quad(@(y)h(kappa(i),y),0,1) - 1;
       
    if ( abs(g(i)) < 10^-3 )
        kappastar = kappa(i);
    end
    
end

