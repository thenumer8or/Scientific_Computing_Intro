function [f,g] = comp_fg ( u, v, imax, jmax, delt, delx, dely, re )

gamma = 0.9;

for i = 2:imax;
    for j = 2:jmax+1
        
        nabla1 = ( u(i-1,j) - 2 * u(i,j) + u(i+1,j) ) / delx^2;
        nabla2 = ( u(i,j-1) - 2 * u(i,j) + u(i,j+1) ) / dely^2;
        nablau = nabla1 + nabla2;
        
        du2dx1 = ( ( u(i,j) + u(i+1,j) )^2 - ( u(i-1,j) + u(i,j) )^2 ); 
        abs1   = abs ( u(i,j) + u(i+1,j) ) * ( u(i,j) - u(i+1,j) );
        abs2   = abs ( u(i-1,j) + u(i,j) ) * ( u(i-1,j) - u(i,j) );
        du2dx  = ( du2dx1 + gamma * ( abs1 - abs2 ) ) / ( 4 * delx );
        
        duvdy1 = ( v(i,j) + v(i+1,j) ) * ( u(i,j) + u(i,j+1) );
        duvdy2 = ( v(i,j-1) + v(i+1,j-1) ) * ( u(i,j-1) + u(i,j) );
        abs1   = abs ( v(i,j) + v(i+1,j) ) * ( u(i,j) - u(i,j+1) );
        abs2   = abs ( v(i,j-1) + v(i+1,j-1) ) * ( u(i,j-1) - u(i,j) );
        duvdy = ( duvdy1 - duvdy2 + gamma * ( abs1 - abs2 ) ) / ( 4 * dely );
                
        f(i,j) = u(i,j) + delt * (nablau / re - du2dx - duvdy);
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
        
        duvdx1 = ( u(i,j) + u(i,j+1) ) * ( v(i,j) + v(i+1,j) );
        duvdx2 = ( u(i-1,j) + u(i-1,j+1) ) * ( v(i-1,j) + v(i,j) );
        abs1   = abs ( u(i,j) + u(i,j+1) ) * ( v(i,j) - v(i+1,j) );
        abs2   = abs ( u(i-1,j) + u(i-1,j+1) ) * ( v(i-1,j) - v(i,j) );
        duvdx  = ( duvdx1 - duvdx2 + gamma * ( abs1 - abs2 ) ) / ( 4 * delx );
             
        dv2dy1 = ( v(i,j) + v(i,j+1) )^2 - ( v(i,j-1) + v(i,j) )^2; 
        abs1   = abs ( v(i,j) + v(i,j+1) ) * ( v(i,j) - v(i,j+1) );
        abs2   = abs ( v(i,j-1) + v(i,j) ) * ( v(i,j-1) - v(i,j) );
        dv2dy  = ( dv2dy1 + gamma * ( abs1 - abs2 ) ) / ( 4 * dely );      
              
        g(i,j) = v(i,j) + delt * (nablav / re - duvdx - dv2dy);
                
    end
end

% g for top & bottom boundaries
g(1:imax+2, 1)      = v(1:imax+2, 1);
g(1:imax+2, jmax+1) = v(1:imax+2, jmax+1);



