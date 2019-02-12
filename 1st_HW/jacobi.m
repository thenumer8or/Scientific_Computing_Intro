m=6;
%A=toeplitz([1.5,1,0,0,0,0])
A=rand(m,m)
xexact=rand(m,1)
b=A*xexact;

N=diag(A)
x=zeros(size(b))
for j=1:20
    x=x-(A*x-b)./N
    error=x-xexact
end
