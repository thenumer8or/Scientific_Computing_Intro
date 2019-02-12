function [u,v]= setbcond ( u, v,  imax, jmax, ubar )
%
%*******************************************************************************
%
% SETBCOND sets the boundary conditions at the boundary strip.
%
%  Discussion:
%          
%    Moreover, no-slip conditions are set at internal obstacle cells
%    by default.                                                    
%
%    For temperature, adiabatic boundary conditions are set.        
%
%  Reference:
%
%    Michael Griebel, Thomas Dornseifer, Tilman Neunhoeffer,
%    Numerical Simulation in Fluid Dynamics,
%    SIAM, 1998.
%
%  Parameters:
%
%    Input/output, real U(0:IMAX+1,0:JMAX+1), V(0:IMAX+1,0:JMAX+1), 
%    P(0:IMAX+1,0:JMAX+1), TEMP(0:IMAX+1,0:JMAX+1), the velocity, 
%    pressure, and temperature fields.
%
%    Input, integer FLAG(0:IMAX+1,0:JMAX+1), indicates the type of each cell.
%
%    Input, integer IMAX, JMAX, the index of the last computational
%    row and column of the grid.
%
%    Input, integer WW, WE, WN, WS, specify the boundary condition
%    to be applied on the west, east, north and south walls.
%    1 = slip
%    2 = no-slip                             
%    3 = outflow
%    4 = periodic  
%

for j=1:jmax+1
    %
    %  Western and eastern boundary.
    %
    u(1,j) = 0.0;
    v(1,j) = - v(2,j);
    u(imax+1,j) = 0.0;
    v(imax+2,j) = -v(imax+1,j);
end

for i = 1:imax+1
    %
    %  Northern and southern boundary
    %
    v(i,jmax+1) = 0.0;
    % Driven cavity
    u(i,jmax+2) = 2.0*ubar - u(i,jmax+1);   
    v(i,1) = 0.0;
    u(i,1) = -u(i,2);
end
