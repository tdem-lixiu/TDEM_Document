% 该函数是关于贝塞尔曲线的程序；作者：曹华科；时间：2018年10月10日；
% 输入：x和y向量，其中向量的顺序为：起始点，控制点，控制点，终点；
%       t：代表输入的变量向量
% 输出：xb，yb是相对应的x(t)，y(t)结果值；
function [xb,yb]=bessel_curve(x,y,t)
bx=3*(x(2)-x(1));
cx=3*(x(3)-x(2))-bx;
dx=x(4)-x(1)-bx-cx;
by=3*(y(2)-y(1));
cy=3*(y(3)-y(2))-by;
dy=y(4)-y(1)-by-cy;
xb=x(1)+t.*(bx+t.*(cx+dx.*t));
yb=y(1)+t.*(by+t.*(cy+dy.*t));
end