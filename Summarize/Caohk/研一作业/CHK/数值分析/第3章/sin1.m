% 程序3.3 构造sin计算器键，#1尝试；作者：曹华科；时间：2018年9月29日；
% 以3阶多项式近似sin曲线；
% 注意：其实精度不够
% 输入：x
% 输出：sin(x)的近似
function y=sin1(x)
b=pi*(0:3)/6;yb=sin(b);
c=newtdd(b,yb);
s=1;
x1=mod(x,2*pi);
if x1>pi
    x1=2*pi-x1;
    s=-1;
end
if x1>pi/2
    x1=pi-x1;
end
y=s*nest(3,c,x1,b);
end
