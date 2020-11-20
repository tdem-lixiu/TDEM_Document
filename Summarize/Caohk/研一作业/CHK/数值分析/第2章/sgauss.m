% 此程序是关于主元高斯消去法的程序；时间：2018.9.17；作者：曹华科；
% 输入：矩阵a是关于元素系数的n*n矩阵，b是关于观测值的1*n矩阵
%中间值说明：eps是a(i,i)上容忍的最小值；
%d是利用主元时换行的中间值，保存该列排序时的最大值，而di时保存d时所在的行号；
% 输出：c是1*n的矩阵解
function c=sgauss(a,b)
if nargin==2
    n=length(b);
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
    %主元换行
    d=a(j,j);
    di=j;
    for i=j:1:n
        if abs(a(i,j))>abs(d)
            d=a(i,j);
            di=i;
        end
    end
    dsort(1:n)=a(j,1:n);
    a(j,1:n)=a(di,1:n);
    a(di,1:n)=dsort(1:n);
    bsort=b(j);
    b(j)=b(di);
    b(di)=bsort;
    %主元换行
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