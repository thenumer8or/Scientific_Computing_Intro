clear all;
close all;
clc;

% *******************************************************************************
%  main.m is the main code for solving the Stokes system
%
%   Initialize.

xlength = 1;
ylength = 1;
imax    = 50;
jmax    = 50;
t_end   = 5;
itermax = 1000;
tol     = 0.001;
omega   = 1.7;
re      = 100;
ui      = 0;
vi      = 0;
ubar    = 1;
%
% Spatial step sizes
%
delx = xlength / imax;
dely = ylength / jmax;
delt = 0.5 * re / ( 1 / delx^2 + 1 / dely^2 );
disp ( sprintf('Time step is %g',delt) )
%
%   Allocate arrays.
%
f   = zeros(imax+1,jmax+2);
g   = zeros(imax+2,jmax+1);
rhs = zeros(imax+2,jmax+2);
%
%  Initialize u and v
%
[u,v,p] = init_uvp ( imax, jmax, ui, vi);
%
%  Initialize the boundary conditions.
%
[u,v] = setbcond ( u, v,  imax, jmax, ubar);
t = 0.0;
%
%  Time loop.
%
while  t < t_end-delt
    %
    %  Compute fields (F,G).
    %
    [f,g] = comp_fg ( u, v, imax, jmax, delt, delx, dely, re );
    %
    %  Compute right-hand side for pressure equation.
    %
    rhs = comp_rhs ( f, g, imax, jmax, delt, delx, dely );
    %
    %  Solve the pressure equation by successive over relaxation (SOR).
    %
    [p,res,iter] = poisson ( p, rhs, imax, jmax, delx, dely, tol, itermax, omega );
    disp ( sprintf('t= %g, # iterations = %i, residual = %g',t+delt,iter,res) )
    %
    %  Compute the new velocity field.
    %
    [u,v] = adap_uv (u, v, f, g, p, imax, jmax, delt, delx, dely );
    %
    %  Set the boundary conditions.
    %
    [u,v] = setbcond ( u, v,  imax, jmax, ubar );
    %
    %  Advance the time
    %
    t = t + delt;
end

plotuv (u,v,p,delx,dely,imax,jmax,t)

disp ( sprintf('\n Stokes Solver ends normally') );
  
