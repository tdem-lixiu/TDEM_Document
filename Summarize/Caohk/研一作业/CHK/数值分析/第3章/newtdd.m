% 程序3.1 牛顿差商插值改进方法；作者：曹华科；时间：2018年9月29日；
% 利用牛顿差商法计算多项式的系数
% 输入：x和y是包含n个数据点的x和y坐标的向量；
% way代表方法，way=0时是计算整个系数矩阵，way=1是更新系数矩阵；
% 输出：嵌套形式的插值多项式系数c；
% 使用nest.m计算插值多项式
% 注意：加入的点必须放在最后一个数组，每次更新一个点
function [c,v]=newtdd(x,y,m,way)
n=length(x);
if nargin==2
    way=0;
end
if way==0
    for i=1:1:n
        v(i,1)=y(i);
    end
    for i=2:1:n
        for j=1:1:n+1-i
            v(j,i)=(v(j,i-1)-v(j+1,i-1))/(x(j)-x(j+i-1));
        end
    end
    
    for i=1:1:n
        c(i)=v(1,i);
    end
end
if way==1
    v=m;
    v(n,1)=y(n);
    for i=2:1:n
        v(n-i+1,i)=(v(n-i+2,i-1)-v(n-i+1,i-1))/(x(n)-x(n-i+1));
    end
    c(1:n)=v(1,1:n);
end

end