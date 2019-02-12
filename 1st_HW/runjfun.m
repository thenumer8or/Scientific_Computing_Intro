m=12;
A=toeplitz([4,1,zeros(1,m-2)]);
xexact=rand(m,1)
b=A*xexact;

Nmax=100
tol=1.e-6

[x,Nstep]=jacobifun(A,b,tol,Nmax)

error=x-xexact