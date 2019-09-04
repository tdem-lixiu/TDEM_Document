% 该子程序主要是利用qwe(即积分外推法中的Wynn's epsilon algorithm)
% 参考文献：kerry key的《Is the fast Hankel transform faster than quadrature?》
% 输入：n_gauss:gauss积分的求积系数个数；
%       n_qmax:求积序列最大的个数；
%       nu:bessel函数的阶数；
%       fres是频率，n是代表n层地层；
%       econ代表各层的电导率，H代表各层的层厚；
%       miu0代表自由空间磁导率常数；
%       I0是电流强度(A)；
%       a是大定回线源的半径；
%       rx是离中心点的距离；
%       z是测量点高度；
%       h是接收线圈的高度；
%       tol_rel是qwe相对容忍误差；
%       tol_abs是qwe的绝对容忍误差；
% 输出：hz：频率域响应；
% 中间量：m代表贝塞尔函数积分自变量；
% 注意事项：
function hz=f_qwe(n_gauss,n_qmax,nu,fres,n,econ,H,miu0,I0,a,rx,z,h,tol_rel,tol_abs)
% ---------------------------处理系数(即类似hankel系数)------------------------%
% 当最大积分序列和高斯积分系数个数要求不变时，并且计算方法不变时
% 即(断点是以Jn的零点不变)，则该系数时稳定不变，不必要重新计算
bx=besselroot(nu,n_qmax);
[gx,gw]=getGaussQuadWeights(n_gauss);
% 用bx0代表积分从0开始
bx0=1d-20;
bx0=(bx(1)-bx0)/2;
dif_gauss=diff(bx)/2;
dif_gauss=[bx0;dif_gauss];
% 行数是n_qmax，列数是n_gauss是gauss系数个数，所以x是关于n_qmax*n_gauss的矩阵
% x包含了最大积分序列所需要的所以x值
gx=gx';
x=repmat(dif_gauss,1,n_gauss).*(repmat(gx,n_qmax,1)-1)+repmat(bx,1,n_gauss);
gw=gw';
gw=repmat(gw,n_qmax,1);
bj=besselj(nu,x).*gw;
% bj是关于存储了所有的g，即计算系数
% 行数是n_qmax，列数是n_gauss是gauss系数个数，所以bj是关于n_qmax*n_gauss的矩阵
% ---------------------------处理系数(即类似hankel系数)------------------------%
%%
n_f=length(fres);
n_disp=length(rx);
hz=zeros(n_disp,n_f);
for k=1:1:n_disp    %rx是存储偏移距的行向量
    r=rx(k);
    for i=1:1:n_f  %fres是存储频率的行向量
        w=fres(i);
%       T是结构数组，详情看qwe子程序的介绍
        T(k,i)=qwe(@getkernel,tol_rel,tol_abs,n_qmax);
%       n_ext是序列的最佳计算值
        n_ext=T(k,i).n;
        hz(k,i)=T(k,i).extrap(n_ext);
    end
end
return;

%%
%------------------------------该子程序是用来计算部分积分结果的----------------------------%
function y=getkernel(i)
% i代表要计算的行数，即Fi
    kx=x/a;
% r_gauss是高斯积分时将下上限a，b转换到-1，1积分域时所产生的附加常数项
    r_gauss=dif_gauss(i)/a;
% 计算所使用的n_gauss个自变量
    m=kx(i,:);
% 计算核函数部分的波阻抗，其是随自变量变换的
    [zu,~,zd0]=Z_cal;
    C=(exp(-m.*abs(z+h))+(zu(1,:)-zd0)./(zu(1,:)+zd0).*exp(m.*(z-h))).*m/2;
% 判断断电时取的哪个bessel函数
    if nu==1
        y=sum(C.*besselj(0,m*r).*bj(i,:));
    end
    if nu==0;
        y=sum(C.*besselj(1,m*r).*bj(i,:));
    end
    y=r_gauss*I0*a*y;
    
    
% ------------------------------计算波阻抗-------------------------------------%
% 该嵌套函数是计算波阻抗的程序；作者：曹华科；时间：2018.10.4；
% 参考文献：《瞬变电磁测深的理论与应用》
% 输入：w是频率，n是代表n层地层；
%       econ代表各层的电导率，H代表各层的层厚；
%       m代表贝塞尔函数积分自变量，行变量；
%       miu代表自由空间磁导率常数；
% 输出：zu是波阻抗上标值；zd代表波阻抗下标值；
%       zd0是空气波阻抗；
%       有n行n_m列，行代表每层的因子，列代表各个m变量时函数值;
function [zu,zd,zd0]=Z_cal
n_m=length(m);
u=zeros(n,n_m);
zd=u;
for ii=1:1:n
    u(ii,1:n_m)=sqrt(m.*m-1i*w*econ(ii)*miu0);
end
for ii=1:1:n
    zd(ii,1:n_m)=-1i*w./u(ii,:)*miu0;
end
zu(n,:)=zd(n,:);
zd0=-1i*w*miu0./m;
for ii=n-1:-1:1
   zu(ii,:)=zd(ii,:).*(zu(ii+1,:)+zd(ii,:).*tanh(u(ii,:).*H(ii)))./(zd(ii,:)+zu(ii+1,:).*tanh(u(ii,:).*H(ii)));
end
end
% ------------------------------计算波阻抗-------------------------------------%
end
%------------------------------该子程序是用来计算部分积分结果的----------------------------%

end