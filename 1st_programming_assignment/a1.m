clc;
close all;
clear all;

Imax = [5,10,15,20];
Jmax = Imax;
dx   = 1./Imax;
dy   = 1./Jmax;

omega = 1.7;
itmax = 500;
tol   = 1.e-04;
maxerror = zeros(1,4);

for iii=1:4;
    
p0    = zeros(Imax(iii)+1,Jmax(iii)+1);
rhs   = zeros(size(p0));

% apply boundary conditions both in vertical and horizontal directions
for i=1:Imax(iii)+1;
    p0(i,1)=sinh(pi*(1-(i-1)*dx(iii))/2) / sinh(pi/2);
    p0(i,Jmax(iii)+1)=0;
end
for j=1:Jmax(iii)+1;
    p0(1,j)=cos(pi*(j-1)*dy(iii)/2);
    p0(Imax(iii)+1,j)=0;
end

p0bc = p0;

[p0,iter,rnorm] = poisson(p0,rhs,dx(iii),dy(iii),tol,itmax,omega);

for i = 1:Imax(iii)+1;
    for j = 1:Jmax(iii)+1;
        uexact(i,j) = cos ( pi*(j-1)*dy(iii)/2 ) * sinh ( pi*(1-(i-1)*dx(iii))/2 ) / sinh(pi/2);
    end
end

maxerror(iii) = max ( max ( abs ( p0 - uexact ) ) )

end

figure
loglog (dx,maxerror,'-*')
title  ('maximum error against dx, w =1.7')
%legend ('w=1.7', 'Location','NorthOutside');
xlabel ('dx');
ylabel ('maximum error');

%subplot (2,2,1)
%mesh(linspace(0,1,Imax+1),linspace(0,1,Jmax+1),p0bc');title('Initial iterate')

%subplot (2,2,2)
%mesh(linspace(0,1,Imax+1),linspace(0,1,Jmax+1),p0');title(sprintf('Solution: Iterate %i',iter))

%subplot (2,2,3)
%semilogy (rnorm,'-');
%title  ('residual against interation number, w =1.7')
%legend ('w=1.7', 'Location','NorthOutside');
%xlabel ('iteration time');
%ylabel ('residual');

