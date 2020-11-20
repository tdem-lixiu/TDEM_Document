% 此程序使关于牛顿法求零值点
% 输入：f函数句柄，x初始值，total使误差容忍值,m代表重根数，如果不是已知可不输入并默认为1；
%中间值：v是求解f(x)的导数时进行差分计算的极小间距x；
% 输出：c近似零值点；
%       k是内部输出值，代表迭代次数；
function c=newton(f,x,total,m)
k=0;
if nargin==3
    m=2;
end
if nargin==2
    m=2;
    total=2.22e-16;
end
if nargin==1
    m=2;
    total=2.22e-16;
    x=0;
end
while abs(f(x))>total
    if x==0
        v=1.e-12;
    else
        v=0.01*x;
    end   
    if k>100
        break;
    end
    k=k+1;
    x=x-(m-1)*f(x)/((f(x+v)-f(x))/v);
end
c=x;
k
end 