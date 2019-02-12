clear all;
close all;
clc;

% *******************************************************************************
%  main.m is the main code for solving the Navier-Stokes system
%
%   Initialize.

xlength = 1;
ylength = 1;
imax    = 64;
jmax    = 64;
t_end   = 15;
itermax = 100;
tol     = 0.001;
omega   = 1.6;
re      = 5000;
ui      = 0;
vi      = 0;
ubar    = 1;
tau     = 0.5;
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
u11 (:,:) = ones (imax+1, jmax+2);
v11 (:,:) = ones (imax+2, jmax+1);
p11 (:,:) = zeros (imax+2, jmax+2);
evolvet = zeros(7);
%
%  Initialize u and v
%
[u,v,p,urep,vrep,prep] = init_uvp ( imax, jmax, ui, vi );
%
%  Initialize the boundary conditions.
%
[u,v] = setbcond ( u, v,  imax, jmax, ubar );
t = 0.0;
%
%  Time loop.
%
while  t < t_end
    %
    %  Compute adaptive time step size.
    %
    delt = comp_delt ( delx, dely, u, v, re, tau);
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
    %  Keep data in memory
    %
    m1 = mod (t, 2);
    m2 = round (t/2);
    if ( t > 1 && m1 < delt)
        urep (m2, :, :) = u;
        vrep (m2, :, :) = v;
        prep (m2, :, :) = p;
        evolvet(m2)     = t; 
    end
    %
    %  Advance the time
    %
    t = t + delt;
end

for i=1:6
    u11 (:,:) = urep(i,:,:);
    v11 (:,:) = vrep(i,:,:);
    p11 (:,:) = prep(i,:,:);
    plotuv (u11(:,:),v11(:,:),p11(:,:),delx,dely,imax,jmax,evolvet(i));
end
plotuv (u,v,p,delx,dely,imax,jmax,t);

disp ( sprintf('\n Navier-Stokes Solver ends normally') );

