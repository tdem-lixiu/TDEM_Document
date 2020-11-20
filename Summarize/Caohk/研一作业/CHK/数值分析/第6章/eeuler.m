% 程序6.1 求解初值问题的欧拉方法
% 使用ydot.m计算微分方程右侧函数的值rhs
% 输入：区间a，b，初值y0，步数n
% 输出：时间步t，解y；
% 使用式例：euler(0,1,1,10)；
function [t,y]=eeuler(a,b,y0,n)
t(1)=a;
y(1)=y0;
h=(b-a)/n;
for i=1:n
    t(i+1)=t(i)+h;
    y(i+1)=eulerstep(t(i),y(i),h);
end
plot(t,y)

function y=eulerstep(t,y,h)
y=y+h*ydot(t,y);
end

function z=ydot(t,y)
    z=t*y+t^3;
end
end