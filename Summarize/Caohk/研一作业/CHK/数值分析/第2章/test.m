% 2.1 高斯消去法实验1
% a=[1 1/2;1/2 1/3];
% b=[1;1];
% n=size(b)
% t0=cputime
% c=gauss(a,b,n)
% t=cputime-t0

%2.2LU分解，例题2.7以及2.2的第1、2道实验题
% a=[1 2 -1;2 1 -2;-3 1 1];
% b=[3;3;-6];
% [L U]=LU(a)
% c=LUback(L,U,b)

%2.3误差分析 实验
% a=[1.e-20 1;1 2];
% b=[1;4];
% c=gauss(a,b,2) %这样得到的计算结果是错误的！

%2.4 与2.3误差分析的对比实验
% a=[1.e-20 1;1 2];
% b=[1;4];
% c=sgauss(a,b) %这样得到的计算结果是错误的！


%2.3误差分析 第15题
% a=[10 20 1;1 1.99 6;0 50 1];
% [L U]=LU(a)

%2.3误差分析 实验1
% n=6;
% a=zeros(n);
% for i=1:1:n
%     for j=1:1:n
%         a(i,j)=5/(i+2*j-1);
%     end
%     x(i)=1;
% end
% b=inv(a)
% for i=1:1:n
%     d(i)=0;
%     f(i)=0;
%     for j=1:1:n
%     d(i)=d(i)+abs(b(i,j));
%     f(i)=f(i)+abs(a(i,j));
%     end
% end
% d
% f

% 2.4 PA=LU 例题2.17
% a=[2 1 5;4 4 -4;1 3 1];
% b=[5;0;6];
% [L U P]=sLU(a)
% b=P*b;
% c=LUback(L,U,b)

% % 2.4 PA=LU 例题2.18
% a=[2 3;3 2];
% b=[4;1];
% [L U P]=sLU(a)
% b=P*b;
% c=LUback(L,U,b)

%2.4实验
% A=[2 1 5;4 4 -4;1 3 1];
% [L,U,P]=lu(A)
% [L U P]=sLU(A)

% 2.4 PA=LU 第9题
% A=[1 0 0 1;-1 1 0 1;-1 -1 1 1;-1 -1 -1 1];
% [L U P]=sLU(A)


% 2.4 实验活动
% clear;
% k=1;
% n=10*2^k;
% if n<5
%     error('the value of n is too small');
% end
% A=sparse(n,n);
% A(1,1:4)=[16 -9 8/3 -1/4];
% A(2,1:4)=[-4 6 -4 1];
% for i=3:1:n-2
%     A(i,i)=6;
%     A(i,i+1)=-4;
%     A(i,i+2)=1;
%     A(i,i-1)=-4;
%     A(i,i-2)=1;
% end
% A(n-1,n-3:n)=[16/17 -60/17 72/17 -28/17];
% A(n,n-3:n)=[-12/17 96/17 -156/17 72/17];
% % condA=cond(A)
% l=2;
% w=0.3;
% d=0.03;
% h=l/n;
% E=1.3e10;
% I=w*d^3/12;
% p=100;
% g=9.8;
% pi=3.141592635;
% x=h:h:l;
% x=x';
% f=-480*g-p*g*sin(pi.*x./l);
% b=f.*h^4/(E*I);
% c=sgauss(A,b)
% % y=(f./(24*E*I)).*x.^2.*(x.^2-4*l.*x+6*l^2);  %关于无载物时的精确解
% y=(f./(24*E*I)).*x.^2.*(x.^2-4*l.*x+6*l*l)-p*g*l/(E*I*pi).*(l^3/(pi^3).*sin(pi/l.*x)-x.^3/6+l/2.*x.^2-l*l.*x./(pi*pi)); %正弦负荷时的精确解
% subplot(1,2,1);
% plot(x,y)
% subplot(1,2,2);
% plot(x,c)
% e=y-c; %误差分析
% z=e(n)/(h*h)
% xlswrite('C:\Users\49640\Desktop\数值分析\第2章\误差分析.xls',e);

% 2.5 例题2.21
% A=[3 1 -1;2 -5 2;1 6 8];
% b=[1;2;3];
% c=jacobi(A,b)

%  2.5 例题2.22
% A=[3 1 -1;2 4 1;-1 2 5];
% b=[4;1;1];
% c=gseidel(A,b)

%  2.5 例题2.23
% A=[3 1 -1;2 4 1;-1 2 5];
% b=[4;1;1];
% c=sor(A,b,1.25)

% 2.5 例题2.24
% A=[3 -1 0 0 0 1/2;-1 3 -1 0 1/2 0;...
%     0 -1 3 -1 0 0;0 0 -1 3 -1 0;...
%     0 1/2 0 -1 3 -1;1/2 0 0 0 -1 3];
% b=[5/2;3/2;1;1;3/2;5/2];
% c=sor(A,b,1.1) %当w=1时，其实就是高斯—塞德尔方法

% 例题2.25
% n=100000;
% [a,b]=sparsesetup(n);
% x=bjacobi(a,b,50)

% 2.5 实验1
% clear;
% n=100;
% [a,b]=sparsesetup(n);
% b(1:n)=1;
% b(n)=2;
% b(1)=2;
% x0=zeros(n,1);
% x=jacobi(a,b,x0,6.8e-7);

% 2.6.2 例题2.28
% A=[4 -2 2;-2 2 -4;2 -4 11];
% R=cholesky(A)

% 2.6.2 例题2.29
% A=[2 2;2 5];
% b=[6;3];
% x=conjugate(A,b)

% 例题2.31
% t0=cputime;
% n=500;
% A=diag(sqrt(1:n))+diag(cos(1:(n-10)),10)+diag(cos(1:(n-10)),-10);
% x0(1:n,1)=1;
% b=A*x0;
% x=conjugate(A,b);
% t1=cputime;
% t=t1-t0
% M=pre(A,1,0);
% M1=inv(M);
% x1=pconjugate(A,b,M1);
% t2=cputime;
% t=t2-t1
% M=pre(A,1,1);
% M1=inv(M);
% x2=pconjugate(A,b,M1);
% t3=cputime;
% t=t3-t2


% 2.6 实验1
% A1=[1 0;0 2];
% b1=[2;4];
% x1=conjugate(A1,b1)
% A2=[1 2;2 5];
% b2=[1 ;1];
% x2=conjugate(A2,b2)

% 2.6 实验2
% clear;
% n=1000;
% m(1:n)=0.5;
% i=n/2;
% A=zeros(n);
% A=diag(m(1:n-i),i)+diag(m(1:n-i),-i)+diag(1:n)+diag(m(1:n-1),1)+diag(m(1:n-1),-1);
% spy(A);
% xe(1:n,1)=1;
% b=A*xe;
% x1=conjugate(A,b);
% w=1;
% M=pre(A,w,0);
% M2=inv(M);
% x2=pconjugate(A,b,M2);
% w=1;
% M=pre(A,w,1);
% M3=inv(M);
% x3=pconjugate(A,b,M3);

% broyden实验
% f=@(x) [x(2)-x(1)^3;x(1)^2+x(2)^2-1];
% x1=broyden1(f,[1;1],10)
% x2=broyden2(f,[1;1],10)

% 2.7 实验1
f1=@(x) [x(1)^2+x(2)^2-1;(x(1)-1)^2+x(2)^2-1];
x1=broyden1(f1,[1;1],10)
f2=@(x) [x(1)^2+4*x(2)^2-4;4*x(1)^2+x(2)^2-4];
x2=broyden1(f2,[1;1],10)
f3=@(x) [x(1)^2-4*x(2)^2-4;(x(1)-1)^2+x(2)^2-4];
x3=broyden1(f3,[1;1],10)




