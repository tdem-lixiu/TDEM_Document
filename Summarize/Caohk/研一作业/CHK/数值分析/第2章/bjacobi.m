% 该程序是书中的雅可比方法；时间：2018.9.27；作者：曹华科；
% 输入：a是系数矩阵；b是观测值；k是迭代次数；
% 输出：解x；
function x=bjacobi(a,b,k)
n=length(b);
d=diag(a);
r=a-diag(d);
x=zeros(n,1);
for j=1:1:k
    x=(b-r*x)./d;
end
end