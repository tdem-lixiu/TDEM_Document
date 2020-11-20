% 程序6.3 求解初值问题的欧拉方法
% 使用ydot.m计算微分方程右侧函数的值rhs
% 输入：区间a，b，初值向量y0，步数n
% 输出：时间步列向量t，解n*2的矩阵y；
% 使用式例：euler(0,1,[0 1],10)；
function [t,y]=euler2(a,b,y0,n)
t(1)=a;y(1,:)=y0;
h=(b-a)/n;
for i=1:1:n
    t(i+1)=t(i)+h;
    y(i+1,:)=eulerstep(t(i),y(i,:),h);
end
t=t';
plot(t,y(:,1),t,y(:,2));

function y=eulerstep(t,y,h)
y=y+h*ydot(t,y);
end

function z=ydot(t,y)
z(1)=y(2)^2-2*y(1);
z(2)=y(1)-y(2)-t*y(2)^2;
end

end