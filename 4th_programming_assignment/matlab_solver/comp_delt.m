function delt=comp_delt (imax, jmax, delx, dely, u, v, re, tau)
%
% !*******************************************************************************
% !
% !! COMP_DELT computes the adaptive time stepsize.
% !
% !  Discussion:
% !
% !    The adaptive time stepsize must satisfy the CFL stability criteria.
% !
% !
% !  Satisfy the CFL conditions.
% !

umax=max([max(max(abs(u(2:imax+1,:)))),1.0e-10]); % avoids problems with divide by zero
vmax=max([max(max(abs(v(:,2:jmax+1)))),1.0e-10]);
deltu = delx / umax;
deltv = dely / vmax;

deltre=0.5*re/(1/delx^2+1/dely^2);
delt=min([deltu,deltv,deltre]);
delt = tau * delt;
