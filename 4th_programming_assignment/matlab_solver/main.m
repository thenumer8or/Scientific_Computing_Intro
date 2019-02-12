clear all
close all
% *******************************************************************************
%
%  main.m is the main code for solving the Navier-Stokes system
%
%  Note that this code is a partial matlab implementation of the 
%  NAST2D C-code that is developed in the book
%  "Numerical Simulation in Fluid Dynamics"
%  by M. Griebel, T. Dornseifer and T. Neunhoeffer
%  published by SIAM in 1997
%
%  Should you ever wish to use the code, I suggest you download
%  their C version from the web (or even the F90 version).  The full
%  version has many more capabilities than our code.  And it has been
%  debugged!
%
%   Initialize.
%
xlength=1;
ylength=1;
imax=64;
jmax=64;
t_end=15;
itermax=100;
tol=0.001;
omega=1.7;
re=5000;
ui=0;
vi=0;
ubar=1;
gam=0.9;
tau=0.5;
%
% Spatial step sizes
%
delx=xlength/imax;
dely=ylength/jmax;
%
%   Allocate arrays.
%
f=zeros(imax+2,jmax+2);
g=zeros(imax+1,jmax+1);
rhs=zeros(imax+2,jmax+2);
%
%  Initialize u and v
%
[u,v,p]= init_uvp ( imax, jmax, ui, vi);

%
%  Initialize the boundary conditions.
%
[u,v]= setbcond ( u, v,  imax, jmax, ubar);
t = 0.0;
%
%  Time loop.
%
handle=progressbar([],0,'Time Step');
while  t < t_end
	delt=comp_delt( imax, jmax, delx, dely, u, v, re, tau);
    %
    %  Compute fields (F,G).
    %
    [f,g]=comp_fg ( u, v, imax, jmax, delt, delx, dely, re, gam );
    %
    %  Compute right-hand side for pressure equation.
    %
    rhs= comp_rhs ( f, g, imax, jmax, delt, delx, dely );
    %
    %  Solve the pressure equation by successive over relaxation (SOR).
    %
    [p,res,iter] = poisson ( p, rhs, imax, jmax, delx, dely, tol, itermax, omega);
    %disp(sprintf('t= %g, # iterations = %i, residual = %g',t+delt,iter,res))
    %
    %  Compute the new velocity field.
    %
    [u,v]=adap_uv (u, v, f, g, p, imax, jmax, delt, delx, dely );
    %
    %  Set the boundary conditions (time independent in this version)
    %
    [u,v]= setbcond ( u, v,  imax, jmax, ubar);
    %
    %  Advance the time
    %
    t = t + delt
    handle=progressbar(handle,delt/t_end);
end
%progressbar(handle,-1);

plotuv(u,v,p,delx,dely,imax,jmax,t)

[x,y,psi] = comp_psi ( u, v, imax, jmax, delx, dely );

figure;
contour (x, y, psi, 300)

disp(sprintf('\n Navier-Stokes Solver ends normally'))
  
