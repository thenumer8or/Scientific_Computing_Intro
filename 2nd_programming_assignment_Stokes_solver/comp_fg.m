function [f,g] = comp_fg ( u, v, imax, jmax, delt, delx, dely, re )

for i = 2:imax;
    for j = 2:jmax+1
        
        nabla1 = ( u(i-1,j) - 2 * u(i,j) + u(i+1,j) ) / delx^2;
        nabla2 = ( u(i,j-1) - 2 * u(i,j) + u(i,j+1) ) / dely^2;
        nablau = nabla1 + nabla2;
                      
        %stokes flow: du2dx = 0 and duvdy = 0;
        f(i,j) = u(i,j) + delt * nablau / re;
    end
end

% f for right & left boundaries
f(1, 1:jmax+2)      = u(1, 1:jmax+2);
f(imax+1, 1:jmax+2) = u(imax+1, 1:jmax+2);

for i = 2:imax+1;
    for j = 2:jmax
        
        nabla1 = ( v(i-1,j) - 2 * v(i,j) + v(i+1,j) ) / delx^2;
        nabla2 = ( v(i,j-1) - 2 * v(i,j) + v(i,j+1) ) / dely^2;
        nablav = nabla1 + nabla2;
        
        %stokes flow: duvdx = 0 and dv2dy = 0;
        g(i,j) = v(i,j) + delt * nablav / re;
    end
end

% g for top & bottom boundaries
g(1:imax+2, 1)      = v(1:imax+2, 1);
g(1:imax+2, jmax+1) = v(1:imax+2, jmax+1);
