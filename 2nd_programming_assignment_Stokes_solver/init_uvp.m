function [u,v,p] = init_uvp (imax, jmax, ui, vi)

u = ui * ones (imax+1, jmax+2);
v = vi * ones (imax+2, jmax+1);
p = zeros (imax+2, jmax+2);
