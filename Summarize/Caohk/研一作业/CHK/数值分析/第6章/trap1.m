% 程序6.2 求解初值微分方程问题的显式梯形方法
% 使用ydot.m计算微分方程右侧函数的值rhs
% 输入：区间a，b，初值y0，步数n
% 输出：时间步t，解y；
% 使用式例：例题：6.10
function [y,t]=trap1(a,b,y0,n)
y(1)=y0;
t(1)=a;
h=(b-a)/n;
for i=1:1:n
    t(i+1)=t(i)+h;
    y(i+1)=trapstep(t(i),y(i),h);
end

function f=trapstep(t,y,h)
f=y+h*ydot(t,y,h)/2;
end

function z=ydot(t,y,h)
y1=t*y+t*t*t;
t1=t+h;
z=y1+t1*(y1*h+y)+t1*t1*t1;
end

end