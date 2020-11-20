% 该程序时关于对角占优的雅可比方法；时间：2018.9.18；作者：曹华科；
% 输入：A是系数矩阵，b是观测值矩阵，a是初始值,eps是变化的最小容忍值
% 输出：x是最终的迭代结果，k代表迭代次数，是程序内部控制迭代的参数；
function x=jacobi(A,b,a,eps)
n=length(b);
if nargin==3
    eps=2.22e-16;
end
if nargin==2
    eps=2.22e-16;
    a(1:n,1)=0;
end
L=zeros(n);
D=b;
U=zeros(n);
for i=1:1:n
    for j=1:1:i-1
        L(i,j)=A(i,j);
    end
    for j=n:-1:i+1
        U(i,j)=A(i,j);
    end 
    D(i)=A(i,i);
end
for i=1:1:n
    Asum=0;
    for j=1:1:n
        Asum=Asum+abs(L(i,j))+abs(U(i,j));
    end
    if Asum>abs(D(i)) || Asum==abs(D(i))
        error('the matrix is not diagonally dominant');
    end
end
x1=a;
x=b;
k=0;
xx(1:n,1)=1;
while norm((x1-xx),inf)>eps 
    if k>100
        break;
    end
    k=k+1;
    x=x1;
    x1=(b-(L+U)*x)./D;
end
k
forward_error=norm(x1-xx,inf)
back_error=norm((b-A*x),inf)
x=x1;
end