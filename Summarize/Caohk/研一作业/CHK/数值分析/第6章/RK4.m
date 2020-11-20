% 程序6.6 龙格-库塔家族RK方法
% 使用ydot.m计算微分方程右侧函数的值rhs
% 输入：区间a，b，初值向量y0，步数n
% 输出：时间步列向量t，解矩阵y；
% 使用式例：RK4(0,1,[0 1],10)；
function [t,y]=RK4(a,b,y0,n)
t(1)=a;y(1,:)=y0;
h=(b-a)/n;
for i=1:1:n
    t(i+1)=t(i)+h;
    y(i+1,:)=RK4step(t(i),y(i,:),h);
end

function z=RK4step(t,y,h)
s1=ydot(t,y);
z1=y+h*s1/2;
s2=ydot(t+h/2,z1);
z2=y+h*s2/2;
s3=ydot(t+h/2,z2);
z3=y+h*s3;
s4=ydot(t+h,z3);
z=y+h*(s1+2*s2+2*s3+s4)/6;
end

function z=ydot(t,y)
z=t*y+t^3;
end

end