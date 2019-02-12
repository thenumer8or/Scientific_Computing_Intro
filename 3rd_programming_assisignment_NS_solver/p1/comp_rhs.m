function rhs = comp_rhs ( f, g, imax, jmax, delt, delx, dely )

for i = 2:imax+1
    for j = 2:jmax+1
        
        dfdx = ( f(i,j) - f(i-1,j) ) /delx;
        dgdy = ( g(i,j) - g(i,j-1) ) /dely;
        
        rhs (i,j) = ( dfdx + dgdy ) / delt;
        
    end
end
