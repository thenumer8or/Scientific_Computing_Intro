function [p0,resp,iter] = poisson(p0,rhs,Imax,Jmax,dx,dy,tol,itmax,omega)

res = zeros ( size (p0) );

iter   = 0;
rrnorm = 1000;

% main SOR loop

p0(1,2:Jmax+1)       = p0(2,2:Jmax+1);
p0(Imax+2,2:Jmax+1)  = p0(Imax+1,2:Jmax+1);
p0(2:Imax+1, 1)      = p0(2:Imax+1, 2);
p0(2:Imax+1, Jmax+2) = p0(2:Imax+1, Jmax+1);

while ( ( rrnorm >= tol ) && ( iter < itmax ) )

    iter = iter + 1;
        
    for i=2:Imax+1
        for j=2:Jmax+1
            p0(i,j)=(1-omega)*p0(i,j) + omega*(((p0(i+1,j)+p0(i-1,j))/dx^2+(p0(i,j+1)+p0(i,j-1))/dy^2)-rhs(i,j))/(2/dx^2+2/dy^2);
        end
    end
    
    for i=2:Imax+1
        for j=2:Jmax+1
            res(i,j)=rhs(i,j)-((p0(i+1,j)-2*p0(i,j)+p0(i-1,j))/dx^2+(p0(i,j+1)+p0(i,j-1)-2*p0(i,j))/dy^2);
        end
    end
    
    sump = sum ( sum ( p0(2:Imax,2:Jmax).^2 ) );
    sump = ( sump / (Imax*Jmax) ) ^ 0.5;
    
    resp = max ( max ( res(:,:) ) );
    
    if ( sump < 0.0001 )
        sump = 0.0001;
    end
    
    sumres = sum ( sum ( res(i,j).^2 ) );
    sumres = ( sumres / (Imax*Jmax) ) ^ 0.5;
    
    rrnorm = sumres / sump;
    
    disp(sprintf('At iterate %i, norm of the residual is %e',iter,norm(res,Inf)))
          
end

