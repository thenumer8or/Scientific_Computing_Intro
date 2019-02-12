function [f,g]=comp_fg ( u, v, imax, jmax, delt, delx, dely, re, gam )

% !*******************************************************************************
% !
% !! COMP_FG computes the F and G fields.
% !
% !  Reference:
% !
% !    Michael Griebel, Thomas Dornseifer, Tilman Neunhoeffer,
% !    Numerical Simulation in Fluid Dynamics,
% !    SIAM 1998.
% !
% !  Parameters:
% !
% !    Input, real U(1:IMAX+2,1:JMAX+2), V(1:IMAX+2,1:JMAX+2),
% !% !
% !    Input, integer IMAX, JMAX, the index of the last computational
% !    row and column of the grid.
% !
% !    Input, real DELT, the time step.
% !
% !    Input, real DELX, DELY, the width and height of one cell.
% !
% !    Input, real GX, GY, the X and Y components of a volume force.
% !
% !    Input, real GAMMA, the upwind differencing factor.
% !
% !    Input, real RE, the Reynolds number.
% !
% !    Input, real BETA, the coefficient of volume expansion.
% !
% !
% !  Compute flux field F
% !
% !
for i = 2: imax
    for j = 2: jmax+1
        du2dx = ((u(i,j)+u(i+1,j))*(u(i,j)+u(i+1,j)) ...
            + gam*abs ( u(i,j)+u(i+1,j))*(u(i,j)-u(i+1,j)) ...
            - (u(i-1,j)+u(i,j))*(u(i-1,j)+u(i,j)) ...
            - gam*abs ( u(i-1,j)+u(i,j))*(u(i-1,j)-u(i,j))) ...
            / (4.0*delx);
        
        duvdy = ((v(i,j)+v(i+1,j))*(u(i,j)+u(i,j+1)) ...
            + gam*abs ( v(i,j)+v(i+1,j))*(u(i,j)-u(i,j+1)) ...
            - (v(i,j-1)+v(i+1,j-1))*(u(i,j-1)+u(i,j)) ...
            - gam*abs ( v(i,j-1)+v(i+1,j-1))*(u(i,j-1)-u(i,j))) ...
            / ( 4.0 * dely );
        
        laplu = ( u(i+1,j) - 2.0 * u(i,j) + u(i-1,j) ) / delx / delx ...
            + ( u(i,j+1) - 2.0 * u(i,j) + u(i,j-1) ) / dely / dely;
        
        f(i,j) = u(i,j) + delt * (laplu / re -du2dx -duvdy) ;
        
    end
end
% !
% !  Compute flux field G
% !
for i = 2: imax+1
    for j = 2: jmax
        duvdx = ((u(i,j)+u(i,j+1))*(v(i,j)+v(i+1,j)) ...
            + gam*abs ( u(i,j)+u(i,j+1))*(v(i,j)-v(i+1,j)) ...
            - (u(i-1,j)+u(i-1,j+1))*(v(i-1,j)+v(i,j)) ...
            - gam*abs ( u(i-1,j)+u(i-1,j+1))*(v(i-1,j)-v(i,j))) ...
            / ( 4.0 * delx );
        
        dv2dy = ((v(i,j)+v(i,j+1))*(v(i,j)+v(i,j+1)) ...
            + gam*abs ( v(i,j)+v(i,j+1))*(v(i,j)-v(i,j+1)) ...
            - (v(i,j-1)+v(i,j))*(v(i,j-1)+v(i,j)) ...
            - gam*abs ( v(i,j-1)+v(i,j))*(v(i,j-1)-v(i,j))) ...
            / ( 4.0 * dely );
        
        
        laplv = ( v(i+1,j) - 2.0 * v(i,j) + v(i-1,j) ) / delx / delx ...
            + ( v(i,j+1) - 2.0 * v(i,j) + v(i,j-1) ) / dely / dely;
        
        g(i,j) = v(i,j) + delt *  ( laplv / re  - duvdx - dv2dy);
        
    end
end
% !
% !  F and G at external boundary
% !
for j = 2: jmax+1
    f(1,j)    = u(1,j);
    f(imax+1,j) = u(imax+1,j);
end

for i = 2: imax+1
    g(i,1)    = v(i,1);
    g(i,jmax+1) = v(i,jmax+1);
end
