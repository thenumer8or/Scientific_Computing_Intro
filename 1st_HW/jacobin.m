m=12;
%A=toeplitz([4,1,zeros(1,m-2)]);
A=toeplitz([2,1,zeros(1,m-2)])
xexact=rand(m,1)
b=A*xexact;

Nmax=10000
tol=1.e-6

N=diag(A);
x=zeros(size(b));
dx=ones(size(x));
Nstep=0;
while norm(dx,inf)/(1+norm(x,Inf))>tol & Nstep<Nmax
    Nstep=Nstep+1;
    dx=(A*x-b)./N;
    x=x-dx;
end

error=norm(x-xexact,inf)/norm(xexact,inf);

disp(sprintf('After %i step the Jacobi solution is x=',Nstep))
disp(sprintf('%g \n',x))
disp(sprintf('With relative infinity norm error = %g ',error))