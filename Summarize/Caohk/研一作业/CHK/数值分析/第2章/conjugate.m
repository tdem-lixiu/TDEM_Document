%该程序是关于书上初步编程的共轭梯度法(conjugate gradient method)；时间：2018.9.28；作者：曹华科；
% 输入：系数矩阵A；观测值矩阵b；初始值x0；
% 输出：解x；
function x=conjugate(A,b,x0)
n=length(b);
if nargin==2
    x0=zeros(n,1);
end
x=x0;
d=b-A*x0;
r=d;
if r==0
    stop;
end
for k=1:1:n
    if norm(r,inf)<2.22e-16
        break;
    end
    ak=(r'*r)/(d'*A*d);
    x=x+ak*d;
    r1=r-ak*A*d;
    bk=(r1'*r1)/(r'*r);
    d=r1+bk*d;
    r=r1;
end 
k
end