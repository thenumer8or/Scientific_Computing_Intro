function plotuv(u,v,p,delx,dely,imax,jmax,t)
%
% function plotuvp(u,v,p,delx,dely,imax,jmax,t)
%
% Interpolates the velocity vectors to the center of the cells in the real
% domain and plots various resuts
%
for i=1:imax
    for j=1:jmax
        uplot(i,j)=(u(i,j+1)+u(i+1,j+1))/2;
        vplot(i,j)=(v(i+1,j)+v(i+1,j+1))/2;
    end
end
x=delx/2+(1:imax)*delx;
y=dely/2+(1:jmax)*dely;
X=ones(jmax,1)*x;
Y=y'*ones(1,imax);

figure
subplot (3,2,1)
mesh(x,y,p(2:imax+1,2:jmax+1));title(sprintf('Pressure at time t= %g',t))

subplot (3,2,2)
mesh(x,y,uplot);title(sprintf('Horizontal velocity at t= %g',t))

subplot (3,2,3)
mesh(x,y,vplot);title(sprintf('Vertical velocity at t= %g',t))

subplot (3,2,4)
quiver(X,Y,uplot',vplot');title(sprintf('Basic quiver plot of the velocity vectors at t= %g',t))
%
%  It is sometimes better not to plot all the velocities
%
cut=0.7;
mask=round(rand(size(uplot)));
[ii,jj]=find(mask==0);
for j=1:length(ii)
    uplot(ii(j),jj(j))=NaN;
    vplot(ii(j),jj(j))=NaN;
end

subplot (3,2,5)
quiver(X,Y,uplot',vplot',4);title(sprintf('Quiver plot of randomly chosen velocity vectors at t= %g',t))