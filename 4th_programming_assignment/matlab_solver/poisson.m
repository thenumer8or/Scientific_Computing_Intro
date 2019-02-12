function [p,res,iter] = poisson ( p, rhs, imax, jmax, delx, dely, tol, itermax, omega)

%*******************************************************************************
%
% POISSON carries out an iterative solution of Poisson's equation.
%
%  Reference:
%
%    Michael Griebel, Thomas Dornseifer, Tilman Neunhoeffer,
%    Numerical Simulation in Fluid Dynamics,
%    SIAM 1998.
%
%  Parameters:
%
%    Input, real P(0:IMAX+1,0:JMAX+1), the pressure field.
%
%    Input, real RHS(0:IMAX+1,0:JMAX+1), ?
%
%    Input, integer FLAG(0:IMAX+1,0:JMAX+1), indicates the type of each cell.
%
%    Input, integer IMAX, JMAX, the index of the last computational
%    row and column of the grid.
%
%    Input, real DELX, DELY, the width and height of one cell.
%
%    Input, real EPS, the stopping tolerance for the pressure iteration.
%
%    Output, integer ITER, the number of iterations taken.
%
%    Input, integer ITERMAX, the maximum number of pressure iterations
%    in one time step.
%
%    Input, real OMEGA, the SOR relaxation parameter.
%
%    Output, real RES, the residual.
%
%    Input, integer IFULL, ?
%
rdx2 = 1.0 / delx / delx;
rdy2 = 1.0 / dely / dely;
beta_2 = - omega / ( 2.0 * ( rdx2 + rdy2 ) );
ifull=imax*jmax;

p0 = 0.0;
for i = 2: imax+1
    for j = 2: jmax+1
        p0 = p0 + p(i,j) * p(i,j);
    end
end
p0 = sqrt ( p0 / ifull );

if  p0 < 0.0001  
    p0 = 1.0;
end
%
%  SOR iteration
%

for iter = 1: itermax

    %
    %  Copy values at external boundary...
    %
    for i = 2: imax+1
        p(i,1)      = p(i,2);
        p(i,jmax+2) = p(i,jmax+1);
    end

    for j = 2: jmax+2
        p(1,j)      = p(2,j);
        p(imax+2,j) = p(imax+1,j);
    end
    %
    %  Relaxation method
    %
    for i = 2:imax+1
        for j = 2:jmax+1
            p(i,j) = ( 1.0 - omega ) * p(i,j) - beta_2 * ( (p(i+1,j) + p(i-1,j)) * rdx2 ...
                +            (p(i,j+1) + p(i,j-1)) * rdy2 - rhs(i,j) );
        end
    end
    %
    %  Computation of the residual.
    %
    res = 0.0;
    for i = 2:imax+1
        for j = 2:jmax+1
            add = ( p(i+1,j) - 2.0 * p(i,j) + p(i-1,j)) * rdx2 ...
                + ( p(i,j+1) - 2.0 * p(i,j) + p(i,j-1)) * rdy2 - rhs(i,j);
            res = res + add * add;

        end
    end

    res = sqrt ( res / ifull ) / p0;

    if  res < tol
        break
    end

end

