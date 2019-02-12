close all
clear all

% grid points chosen to be the same in both directions.
% in general they may not be the same
Imax=40;
Jmax=Imax;

% introduce and initiate the unknown (p), right hand side (rhs)
% and residue (res)
p1=zeros(Imax+1,Jmax+1);
p2=zeros(Imax+1,Jmax+1);
p3=zeros(Imax+1,Jmax+1);
rhs=zeros(size(p1));
res1=zeros(size(p1));
res2=zeros(size(p1));
res3=zeros(size(p1));

% over relaxation parameter
omega1=1;
omega2=1.7;
omega3=2.7;

% grid size
dx=1/Imax;
dy=1/Jmax;

% force horizontal boundary conditions
for i=1:Imax+1
    p1(i,1)=0;
    p1(i,Jmax+1)=0;
end

% force vertical boundary conditions
for j=1:Jmax+1;
    y=dy*(j-1);
    p1(1,j)=sin(2*pi*y);
    p1(Imax+1,j)=0;
end

p2=p1;
p3=p1;

% figure
% mesh(linspace(0,1,Imax+1),linspace(0,1,Jmax+1),p1');title('Initial iterate')

% maximum number of iteration
itmax=200;

for it=1:itmax
    for i=2:Imax
        for j=2:Jmax
            p1(i,j)=(1-omega1)*p1(i,j)+omega1*( (((p1(i+1,j)+p1(i-1,j))/dx^2+(p1(i,j+1)+p1(i,j-1))/dy^2)-rhs(i,j))/(2/dx^2+2/dy^2) );
            p2(i,j)=(1-omega2)*p2(i,j)+omega2*( (((p2(i+1,j)+p2(i-1,j))/dx^2+(p2(i,j+1)+p2(i,j-1))/dy^2)-rhs(i,j))/(2/dx^2+2/dy^2) );
            p3(i,j)=(1-omega3)*p3(i,j)+omega3*( (((p3(i+1,j)+p3(i-1,j))/dx^2+(p3(i,j+1)+p3(i,j-1))/dy^2)-rhs(i,j))/(2/dx^2+2/dy^2) );
        end
    end
    for i=2:Imax
        for j=2:Jmax
            res1(i,j)=rhs(i,j)-((p1(i+1,j)-2*p1(i,j)+p1(i-1,j))/dx^2+(p1(i,j+1)+p1(i,j-1)-2*p1(i,j))/dy^2);
            res2(i,j)=rhs(i,j)-((p2(i+1,j)-2*p2(i,j)+p2(i-1,j))/dx^2+(p2(i,j+1)+p2(i,j-1)-2*p2(i,j))/dy^2);
            res3(i,j)=rhs(i,j)-((p3(i+1,j)-2*p3(i,j)+p3(i-1,j))/dx^2+(p3(i,j+1)+p3(i,j-1)-2*p3(i,j))/dy^2);
        end
    end
    rnorm1(it)=norm(res1,Inf);
    rnorm2(it)=norm(res2,Inf);
    rnorm3(it)=norm(res3,Inf);
    disp(sprintf('At iterate %i, norm of the residual is %e',it,norm(res1,Inf)))
%     figure
%     mesh(linspace(0,1,Imax+1),linspace(0,1,Jmax+1),p');title(sprintf('Solution: Iterate %i',it))
%     figure
%     contourf(linspace(0,1,Imax+1),linspace(0,1,Jmax+1),abs(res'));title(sprintf('Residual: Iterate %i',it));
%     colorbar
%     pause
%     close all
end

% figure
% mesh(linspace(0,1,Imax+1),linspace(0,1,Jmax+1),p');title(sprintf('Solution: Iterate %i',it))
% 
% figure
% contourf(linspace(0,1,Imax+1),linspace(0,1,Jmax+1),abs(res'));title(sprintf('Residual: Iterate %i',it));
% colorbar

x=1:itmax;
figure
semilogy(x,rnorm1,'-k',x,rnorm2,'-.k',x,rnorm3,'--k'),title('residual against interation number')
xlabel ('number of iteration');
ylabel ('residual')
h = legend('w=1','w=1.7','w=2.7');
set(h,'Interpreter','none')

