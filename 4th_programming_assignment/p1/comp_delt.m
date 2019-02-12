function delt = comp_delt ( delx, dely, u, v, re, tau )

umax = max ( max ( abs(u) ) );
vmax = max ( max ( abs(v) ) );

t1   = 0.5 * re / ( 1 / delx^2 + 1 / dely^2 );
delt = min ( delx/umax, dely/vmax );
delt = tau * min ( delt, t1 );
