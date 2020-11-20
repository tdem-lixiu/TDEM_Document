% 此方程是割线法的改进算法：IQI(逆二次插值)
% 输入：f函数句柄，x0,x1,x2初始值，total误差容忍值；
%       对x0,x2,x1需要进行从小到大的排序
% 输出：c近似零值点，
%       k迭代次数；
function c=IQI(f,x0,x1,x2,total)
if nargin==4
    total=2.22e-16;
end 
if nargin<4
    error('Please input more than three parameters');
end
if abs((f(x1)-f(x0))*(x2-x1)-(f(x2)-f(x1))*(x1-x0))<2.22e-16
    error('three points on a straight line');
end
k=0;
while abs(f(x2))>total
    if k>100
        break;
    end
    k=k+1;
    xmax=max(max(x0,x1),x2);
    xmin=min(min(x0,x1),x2);
    x2=x0+x1+x2-xmax-xmin;
    x0=xmin;
    x1=xmax;
    q=(f(x0))/(f(x1));
    r=(f(x2))/(f(x1));
    s=(f(x2))/(f(x1));
    x3=x2-(r*(r-q)*(x2-x1)+(1-r)*s*(x2-x1))/((q-1)*(r-1)*(s-1));
    x0=x1;
    x1=x2;
    x2=x3;
    x2
end
c=x2;
k
end 