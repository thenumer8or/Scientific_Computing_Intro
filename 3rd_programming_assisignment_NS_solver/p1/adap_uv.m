function [u,v] = adap_uv (u, v, f, g, p, imax, jmax, delt, delx, dely )

for i=1:imax
    for j=1:jmax+1
        u(i,j) = f(i,j) - (delt / delx) * ( p(i+1,j) - p(i,j) );
    end
end

for i=1:imax+1
    for j=1:jmax
        v(i,j) = g(i,j) - (delt / dely) * ( p(i,j+1) - p(i,j) );
    end
end
