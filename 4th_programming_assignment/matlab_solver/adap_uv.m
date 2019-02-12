function [u,v]=adap_uv (u, v, f, g, p, imax, jmax, delt, delx, dely )
%
% !*******************************************************************************
% !
% !! ADAP_UV computes the U and V fields if adjacent cells are fluid cells.
% !
% !  Discussion:
% !
% !    We only update U or V when both adjacent cells are fluid cells.
% !
% !  Reference:
% !
% !    Michael Griebel, Thomas Dornseifer, Tilman Neunhoeffer,
% !    Numerical Simulation in Fluid Dynamics,
% !    SIAM 1998.
% !
% !  Parameters:
% !
% !    Input/output, real U(0:IMAX+1,0:JMAX+1), V(0:IMAX+1,0:JMAX+1),
% !    the velocity field.
% !
% !    Input, real F(0:IMAX+1,0:JMAX+1), G(0:IMAX+1,0:JMAX+1), ?
% !
% !    Input, real P(0:IMAX+1,0:JMAX+1), the pressure field.
% !
% !    Input, integer IMAX, JMAX, the index of the last computational
% !    row and column of the grid.
% !
% !    Input, real DELT, the time step.
% !
% !    Input, real DELX, DELY, the width and height of one cell.
% !
for i = 2: imax
    for j = 2: jmax+1
        u(i,j) = f(i,j) - ( p(i+1,j) - p(i,j) ) * delt / delx;
    end
end

for i = 2: imax+1
    for j = 2: jmax
        v(i,j) = g(i,j) - ( p(i,j+1) - p(i,j) ) * delt / dely;
    end
end

