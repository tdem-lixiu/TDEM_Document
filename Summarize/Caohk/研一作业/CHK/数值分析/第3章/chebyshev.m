% 程序3.4 构造函数的切比雪夫；作者：曹华科；时间：2018年9月29日；
% 使用n阶多项式近似函数
% 输入：f函数句柄；a，b是左右区间；x是自变量；n是阶数；
% 输出：输出近似函数的值，并输出近似图像和真实图像，以及误差；
function y=chebyshev(f,a,b,x,n)
if nargin==4
    n=9;
end
ni=n+1;  %插值点数
xi=(a+b)/2+(b-a)/2*cos((1:2:2*ni-1)*pi/(2*ni));
yi=f(xi);
c=newtdd(xi,yi);
y=nest(n,c,x,xi);
ytrue=f(x);
subplot(1,2,1);
plot(xi,yi,'o',x,y,'r:',x,ytrue,'b');grid on;
subplot(1,2,2);
plot(x,ytrue-y);grid on;
end