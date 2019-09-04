% 该程序是求解第一类bessel函数的一系列零点值
% 参数参考的是Kerry Key的《Is the fast Hankel transform faster than quadrature?》的代码
% 使用方法：利用的是非线性牛顿下山法
% 输入：nu是阶数，
%       n是计算的零点个数；
% 输出：零点数组值x(为列向量)
% 注意事项：0<=nu<=10,0<n<=10，且n，v应为整数
% 该处由于bessel函数的导数是存在解析的，具体推导见bessel函数的递推性
function x=besselroot(nu,n)
%利用大宗量近似来估计零点大致点
%参考文献：顾樵的《数学物理方法》第419页
x=(1:n)'*pi+nu*pi/2-pi/4;
n_iter=10;   %最大迭代次数
for k=1:1:n_iter
    y0=besselj(nu,x);
    y1=nu./x.*y0;
    y2=besselj(nu+1,x);
    %y1-y2是该函数的导数
    h=-y0./(y1-y2);
    %步长
    x=x+h;
    %判断是否达到精度要求
    if all(abs(h)<8*eps(x))
        break;
    end
end      
end