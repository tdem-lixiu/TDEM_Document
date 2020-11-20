% 程序5.2自适应积分
% 计算定积分的近似
% 输入：Matlab函数f，区间[a0,b0]
% 容差tolo
% way是积分方式的选择，way=1是梯形积分，way=2是辛普森积分
% 输出：近似定积分
% 中间变量说明：mul_facto是积分方式的倍数因子；c是划分子区间的中间变量；
%              app是子区间的计算结果；
function [int,n_adap]=adapquad(f,a0,b0,tolo,way)
if nargin==4
    way=2;
end
if way==1
    mul_factor=3;
end
if way==2
%     mul_factor=15;
    mul_factor=10;
end
int=0;n=1;a(1)=a0;b(1)=b0;
tol(1)=tolo;
app(1)=trap(f,a,b,way);

n_adap=1;
while  n>0
    c=(a(n)+b(n))/2;
    oldapp=app(n);
    app(n)=trap(f,a(n),c,way);app(n+1)=trap(f,c,b(n),way);
    if abs(oldapp-app(n)-app(n+1))<mul_factor*tol(n)
        int=int+app(n)+app(n+1);
        n_adap=n_adap+1;
        n=n-1;
    else
        b(n+1)=b(n);b(n)=c;
        a(n+1)=c;
        tol(n)=tol(n)/2;tol(n+1)=tol(n);
        n_adap=n_adap+1;
        n=n+1;
    end
end

function s=trap(f,a,b,way)
    if way==1
        s=(f(a)+f(b))*(b-a)/2;
    end
    if way==2
        s=(f(a)+4*f((a+b)/2)+f(b))*(b-a)/6;
    end        
end
end
    