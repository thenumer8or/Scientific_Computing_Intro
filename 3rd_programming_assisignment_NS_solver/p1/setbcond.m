function [u,v] = setbcond ( u, v,  imax, jmax, ubar)

% North
u (1:imax+1, jmax+2) = 2 * ubar - u (1:imax+1, jmax+1);
v (1:imax+2, jmax+1) = 0;

% South
u (1:imax+1, 1) = - u (1:imax+1, 2);
v (1:imax+2, 1) = 0;

% East
u (imax+1, 1:jmax+2) = 0;
v (imax+2, 1:jmax+1) = - v (imax+1, 1:jmax+1);

% West
u (1, 1:jmax+2) = 0;
v (1, 1:jmax+1) = - v (2, 1:jmax+1);


