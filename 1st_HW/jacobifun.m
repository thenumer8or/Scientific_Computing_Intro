function [x,Nstep]=jacobifun(A,b,tol,Nmax)
%
%Jacobi method function
%[x,Nstep]=jacobifun(A,b,tol,Nmax)
%
% A=matrix (mxm)
% b=right hand side vector (mx1)
% tol=stopping tolerance
% Nmax=maximum number of Jacobi steps

N=diag(A);
x=zeros(size(b));
dx=ones(size(x));
Nstep=0;
while norm(dx,inf)/(1+norm(x,Inf))>tol & Nstep<Nmax
    Nstep=Nstep+1;
    dx=(A*x-b)./N;
    x=x-dx;
end