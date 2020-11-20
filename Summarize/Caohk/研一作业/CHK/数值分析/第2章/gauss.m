% 此程序是关于朴素高斯消去法；时间：2018.9.15；作者：曹华科；
% 输入：矩阵a是关于元素系数的n*n矩阵，b是关于观测值的1*n矩阵
%       n是矩阵大小
% 输出：c是1*n的矩阵解
function c=gauss(a,b,n)
if nargin==2
    n=size(b);
end
eps=1.e-22;
c=b;

for i=1:1:n
    if a(i,i)==0
        error('a(i,i)=0');
    end
end

%先用高斯消去法将系数矩阵化为上三角矩阵
for j=1:1:n-1        %列
    if abs(a(j,j))<eps
        error('zero pivot encountered');
    end
    for i=j+1:1:n    %行
        h=a(i,j)/a(j,j);
        for k=j+1:1:n
            a(i,k)=a(i,k)-a(j,k)*h;
        end
        b(i)=b(i)-h*b(j);
    end
end
%先用高斯消去法将系数矩阵化为上三角矩阵

%解方程
for i=n:-1:1
    c(i)=0;
    for j=n:-1:i+1
        c(i)=c(i)-a(i,j)*c(j);
    end
    c(i)=(c(i)+b(i))/a(i,i);
end
%解方程

end