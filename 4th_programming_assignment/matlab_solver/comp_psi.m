function [x,y,psi] = comp_psi ( u, v, imax, jmax, delx, dely )

x   = zeros (imax+1, jmax+1);
y   = zeros (imax+1, jmax+1);
psi = zeros (imax+1, jmax+1);
psi (:, 1) = 0;

for i = 1:imax+1;
    for j = 2:jmax+1
        
        psi (i,j) = psi(i,j-1) + u(i,j) * dely;
        x (i,j)   = delx * i;
        y (i,j)   = dely * j;
        
    end
end