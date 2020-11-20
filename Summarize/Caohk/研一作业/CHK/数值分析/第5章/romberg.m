% 程序 5.1 龙贝格积分
% 计算积分近似
% 输入：MATLAB函数定义被积函数f，
% a,b 积分区间，n=行数
% 输出：龙贝格表r
function r=romberg(f,a,b,n)
h=(b-a)./(2.^(0:n-1));
r(1,1)=(b-a)*(f(a)+f(b))/2;
for j=2:n
    subtotal=0;
    for i=1:2^(j-2)
        subtotal=subtotal+f(a+(2*i-1)*h(j));
    end
    r(j,1)=r(j-1,1)/2+h(j)*subtotal;
    for k=2:j
        r(j,k)=(4^(k-1)*r(j,k-1)-r(j-1,k-1))/(4^(k-1)-1);
    end
end
end