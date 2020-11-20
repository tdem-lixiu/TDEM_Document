% 程序2.3 Broyden方法Ⅰ；时间：2018.9.29；作者：曹华科；
% 输入：初始向量x0，最大步数k，初始矩阵a
% 输出：解x
% 使用示例：broyden1(f,[1;1],10)
function x=broyden1(f,x0,k,a)
[n,m]=size(x0);
if nargin==3
    a=eye(n,n);
end
for i=1:1:k
    s=sgauss(a,-f(x0));
    x=x0+s;
    del=x-x0;delta=f(x)-f(x0);
    a=a+(delta-a*del)*del'/(del'*del);
    x0=x;
end
end