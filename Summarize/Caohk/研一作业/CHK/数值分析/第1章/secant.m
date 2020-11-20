% 该程序是关于割线法求取零值点的
% 输入：f函数句柄，x0，x1代表初始值，total误差容忍值；
% 输出：c近似零值点，
%       k内部函数输出值，代表迭代次数；
function c=secant(f,x0,x1,total)
if nargin==3
    total=2.22e-16;
end 
if nargin==2 
    error('the number of input parameters is not satisfied');
end 
if nargin==1
    total=2.22e-16;
    x0=-1.5;
    x1=1;
end
k=1;
while abs(f(x1))>total
    if f(x1)==f(x0)
        error('f(x1)=f(x0)');
    end 
    if k>100
        break;
    end
    k=k+1;
    x2=x1-(f(x1)*(x1-x0))/(f(x1)-f(x0));
    x0=x1;
    x1=x2;
end 
c=x1;
k
end 