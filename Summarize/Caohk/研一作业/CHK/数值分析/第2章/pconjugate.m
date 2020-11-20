%该程序是关于书上的预条件共轭梯度法(conjugate gradient method)；时间：2018.9.28；作者：曹华科；
% 输入：系数矩阵A；观测值矩阵b；预条件矩阵的逆M1；初始值x0；
% 输出：解x；
function x=pconjugate(A,b,M1,x0)
n=length(b);
if nargin==3
    x0=zeros(n,1);
end
x=x0;
r=b-A*x0;
d=M1*r;
z=d;
if r==0
    exit;
end
for k=1:1:n
    if norm(r,inf)<2.22e-16
        break;
    end
    rz=r'*z;
    Ad=A*d;
    ak=(rz)/(d'*Ad);
    x=x+ak*d;
    r1=r-ak*Ad;
    z1=M1*r1;
    bk=(r1'*z1)/(rz);
    d=z1+bk*d;
    r=r1;
    z=z1;
end 
k
end