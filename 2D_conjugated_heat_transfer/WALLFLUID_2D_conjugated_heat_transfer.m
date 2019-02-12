


% PROGRAM IN MATLAB TO SOLVE 2D TRANSIENT CONJUCATED HEAT TRANSFER %
%                     BY: HOSSEIN PARISHANI                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc
clear all
close all
%%%%%%%%%%%%%% flexible parameters %%%%%%%%%%%%%
a=5;
pe=5;
d=0.1;
ksf=10;
x1=1.1;
x0=-0.3;
tmax=300;
alphasf=1;
deltarf=0.02;
deltax=0.025;
deltat=0.0001;
%%%%%%%%%%%%%%%%%%%%% fixed data %%%%%%%%%%%%%%%
r=1+d;
deltars=d/(a-1);
e=(x1-x0)/deltax;
c=e+1;
x=x0:deltax:x1;
Rs=r:-deltars:1;
Rf=1:-deltarf:0;
f=1/deltarf;
b=f+1;

Ts1=zeros(a,c);
Ts1(:,1)=0;
Ts1(:,c)=0;
Tw=0;
Tf1=zeros(b,c);
Tf=Tf1;
for j=1:1:c
   xx=x0+(j-1)*deltax;
   if xx>=0
      Ts1(1,j)=1;
   end
end
Ts=Ts1;

for k=1:1:tmax
   %%%%%%%%%%%%%%%%%%%% wall region %%%%%%%%%%%%%%%%%%%%
   tmax
   t=k
   %%%%%%%%%%%%%%
   r=1+d;
   for i=2:1:a-1
      r=r-deltars;
      for j=2:1:c-1
         aa=Ts1(i,j+1);
         bb=Ts1(i,j);
         cc=Ts1(i,j-1);
         dd=Ts1(i-1,j);
         ee=Ts1(i+1,j);
         Ts(i,j)=bb+alphasf*deltat*((bb-ee)/(r*deltars)+(ee-2*bb+dd)/deltars^2+(aa-2*bb+cc)/(pe*deltax)^2);
      end
   end
   %%%%%%%%%%%%%%
   i=a;   
   r=1;
   for j=2:1:c-1
      aa=Ts1(i,j+1);
      bb=Ts1(i,j);
      cc=Ts1(i,j-1);
      dd=Ts1(i-1,j);
      ff=Ts1(i-2,j);
      Ts(i,j)=bb+alphasf*deltat*((dd-bb)/(r*deltars)+(ff-2*dd+bb)/deltars^2+(aa-2*bb+cc)/(pe*deltax)^2);
   end 
   %%%%%%%%%%%%%%
   for i=2:1:a
      Ts(i,c)=Ts1(i,c-1);
   end 
   %%%%%%%%%%%%%%
   Ts1=Ts;   
   
   %%%%%%%%%%%%%%%%%%% Fluid region %%%%%%%%%%%%%%%%%%%
   
   Tf1(1,:)=Ts(a,:);
   Tf(1,:)=Tf1(1,:);
   Tf(2,:)=Tf1(1,:)-ksf*(deltarf/deltars)*(Ts(a-1,:)-Ts(a,:));
   %%%%%%%%%%%%%%
   r=1;
   for i=2:1:(b-1)
      r=r-deltarf;
      for j=2:1:c-1
         aa=Tf1(i,j+1);
         bb=Tf1(i,j);
         cc=Tf1(i,j-1);
         dd=Tf1(i-1,j);
         ee=Tf1(i+1,j);
         Tf(i,j)=bb+deltat*((bb-ee)/(r*deltarf)+(ee-2*bb+dd)/deltarf^2+(aa-2*bb+cc)/(pe*deltax)^2+(r^2-1)*(aa-bb)/(deltax));
      end
   end
   %%%%%%%%%%%%%%%
   for j=2:1:c-1
      Tf(b,j)=Tf1(b,j);
   end
   %%%%%%%%%%%%%%
   for i=2:1:b-1
      Tf(i,c)=Tf1(i,c-1);
   end
   %%%%%%%%%%%%%%%
   Tf(b,c)=Tf1(b-1,c);
   Tf1=Tf;
end

%%%%%%%%%%%%  calculating and plotting qw  %%%%%%%%%%%%%%%
qw=(Tf(1,:)-Tf(2,:))/deltarf;
subplot(141)
plot(x,qw);
axis([x0 0.7 -2 10]);
xlabel('x');
ylabel('qw');

%%%%%%%%%%%%  calculating and plotting Tb  %%%%%%%%%%%%%%%
Tb=zeros(1,c);
for i=2:1:(b-1)
   Tb=Tb+4*2*Rf(i)*(1-Rf(i)^2)*Tf(i,:);
end
Tb=(deltarf/2)*Tb;
subplot(142)
plot(x,Tb);
axis([x0 1 0 1]);
xlabel('x');
ylabel('Tb');

%%%%%%%%%%%%  calculating and plotting Tw  %%%%%%%%%%%
Tw=(Tf(2,:)+Tf(1,:))/2;
subplot(143)
plot(x,Tw);
axis([x0 1 0 1]);
xlabel('x');
ylabel('Tw');

%%%%%%%%%%%%  calculating and plotting Nu  %%%%%%%%%%%
Nu=2*qw./(Tf(1,:)-Tb);
subplot(144)
plot(x,Nu);
xlabel('x');
ylabel('Nu');
axis([x0 1 min(Nu)-5 max(Nu)+5]);






















