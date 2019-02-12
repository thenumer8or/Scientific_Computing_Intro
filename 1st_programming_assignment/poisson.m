function [p0,iter,rnorm] = poisson(p0,rhs,dx,dy,tol,itmax,omega)

res=zeros(size(p0));

Imax = 1/dx;
Jmax = 1/dy;

iter   = 0;
rrnorm = 1000;

% main SOR loop
while ( ( rrnorm >= tol ) && ( iter < itmax ) )

    iter = iter + 1;
    
    for i=2:Imax
        for j=2:Jmax
            p0(i,j)=(1-omega)*p0(i,j) + omega*(((p0(i+1,j)+p0(i-1,j))/dx^2+(p0(i,j+1)+p0(i,j-1))/dy^2)-rhs(i,j))/(2/dx^2+2/dy^2);
        end
    end
    
    for i=2:Imax
        for j=2:Jmax
            res(i,j)=rhs(i,j)-((p0(i+1,j)-2*p0(i,j)+p0(i-1,j))/dx^2+(p0(i,j+1)+p0(i,j-1)-2*p0(i,j))/dy^2);
        end
    end
    
    rnorm(iter)=norm(res,Inf);
    rrnorm = rnorm(iter);
    
    disp ( sprintf('At iterate%i,w=%f, norm of the residual is %e',iter,omega,norm(res,Inf)) )
    
end