function [u,v,p,urep,vrep,prep] = init_uvp (imax, jmax, ui, vi)

u = ui * ones (imax+1, jmax+2);
v = vi * ones (imax+2, jmax+1);
p = zeros (imax+2, jmax+2);

urep = ones (7, imax+1, jmax+2); 
vrep = ones (7, imax+2, jmax+1); 
prep = zeros (7, imax+2, jmax+2); 
