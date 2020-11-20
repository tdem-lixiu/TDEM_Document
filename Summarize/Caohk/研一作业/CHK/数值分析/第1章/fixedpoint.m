% 该函数使利用不动点迭代法计算近似零值点
% 输入：函数句柄f；初始值a；容差total；
% 非返回输出值：迭代次数k；
% 输出：近似零值点c
function c=fixedpoint(f,a,total)
k=0;
if nargin==2
    total=1.e-10;
end
fa=f(a);
while abs(fa-a)>total
    a=fa;
    fa=f(a);
    k=k+1;
end
c=a;
k
end
    