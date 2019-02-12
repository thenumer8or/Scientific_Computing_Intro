function rhs= comp_rhs ( f, g, imax, jmax, delt, delx, dely )
% 
% !*******************************************************************************
% !
% !! COMP_RHS computes the righthand side field.
% !
% !  Reference:
% !
% !    Michael Griebel, Thomas Dornseifer, Tilman Neunhoeffer,
% !    Numerical Simulation in Fluid Dynamics,
% !    SIAM 1998.
% !
% !  Parameters:
% !
% !    Input, real F(0:IMAX+1,0:JMAX+1), G(0:IMAX+1,0:JMAX+1), ?
% !
% !    Output, real RHS(0:IMAX+1,0:JMAX+1), ?
% !
% !    Input, integer IMAX, JMAX, the index of the last computational
% !    row and column of the grid.
% !
% !    Input, real DELT, the time step.
% !
% !    Input, real DELX, DELY, the width and height of one cell.
% !
for i = 2: imax+1
    for j = 2: jmax+1

        rhs(i,j) = ( ( f(i,j) - f(i-1,j) ) / delx ...
            +   ( g(i,j) - g(i,j-1) ) / dely ) / delt;

    end
end
