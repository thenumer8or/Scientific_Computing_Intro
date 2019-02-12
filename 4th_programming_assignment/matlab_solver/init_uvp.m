function [u,v,p]= init_uvp ( imax, jmax, ui, vi)
% 
% !*******************************************************************************
% !
% !! INIT_UVP initializes the U, V, P, fields.
% !
% !  Reference:
% !
% !    Michael Griebel, Thomas Dornseifer, Tilman Neunhoeffer,
% !    Numerical Simulation in Fluid Dynamics,
% !    SIAM, 1998.
% !
% !  Parameters:
% !
% !
% !    Input/output, real U(0:IMAX+1,0:JMAX+1), V(0:IMAX+1,0:JMAX+1), 
% !    P(0:IMAX+1,0:JMAX+1),  the velocity, 
% !    pressure,  fields.
% !
% !    Input, integer IMAX, JMAX, the index of the last computational
% !    row and column of the grid.
% !
% !    Input, real UI, VI, TI, scalars that may be used to initialize 
% !    the flow and temperature.
% !

u=ui*ones(imax+1,jmax+2);
v=vi*ones(imax+2,jmax+1);
p=zeros(imax+2,jmax+2);

 