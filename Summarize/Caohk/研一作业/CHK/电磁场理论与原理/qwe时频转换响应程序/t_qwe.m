% 该子程序主要是利用qwe(即积分外推法中的Wynn's epsilon algorithm)
% 参考文献：kerry key的《Is the fast Hankel transform faster than quadrature?》
% 输入：n_gauss:gauss积分的求积系数个数；
%       n_qmax:求积序列最大的个数；
%       n是代表n层地层；
%       econ代表各层的电导率，H代表各层的层厚；
%       miu0代表自由空间磁导率常数；
%       I0是电流强度(A)；
%       a是大定回线源的半径；
%       r是离中心点的距离；
%       z是测量点高度；
%       h是接收线圈的高度；
%       tol_rel是qwe相对容忍误差；
%       tol_abs是qwe的绝对容忍误差；
%       t是计算的时间点
% 输出：hz：时间域响应；
% 中间量：hz_f代表频率域响应；
% 注意事项：
function hz=t_qwe(n_gauss,n_qmax,n,econ,H,miu0,I0,a,r,z,h,tol_rel,tol_abs,t)
% ---------------------------处理系数(即类似hankel系数)------------------------%
% 当最大积分序列和高斯积分系数个数要求不变时，并且计算方法不变时
% 即(断点是以pi/2，即sin函数的零点值)，则该系数时稳定不变，不必要重新计算
bx=pi/2*((1:n_qmax));
bx=bx';
[gx,gw]=getGaussQuadWeights(n_gauss);

gx   %输出高斯节点位置

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
bj_dhzdt=sin(x).*gw;
% bj是关于存储了所有的g，即计算系数
% 行数是n_qmax，列数是n_gauss是gauss系数个数，所以bj是关于n_qmax*n_gauss的矩阵
% ---------------------------处理系数(即类似hankel系数)------------------------%
%%
% n_f=length(fres);
% n_disp=length(rx);
% hz=zeros(n_disp,n_f);
nt=length(t);
for i=1:1:nt  %nt是时间点的个数
    tt=t(i);
    %       T是结构数组，详情看qwe子程序的介绍
    T(i)=qwe(@getkernel,tol_rel,tol_abs,n_qmax);
    %       n_ext是序列的最佳计算值
    n_ext=T(i).n;
    hz_n(i)=n_ext;
    hz(i)=T(i).extrap(n_ext);
end

hz_n  %输出每个时间点计算时所用的部分积分个数

return;

%%
%------------------------------该子程序是用来计算部分积分结果的----------------------------%
function y=getkernel(i)
% i代表要计算的行数，即Fi
    kx=x/tt;
% r_gauss是高斯积分时将下上限a，b转换到-1，1积分域时所产生的附加常数项
    r_gauss=dif_gauss(i)/tt;
% 计算所使用的n_gauss个自变量
    wt=kx(i,:);
% 计算频率域响应
    hz_f=hankel_Gups(wt,r,a,I0,h,z,n,econ,H,miu0);
% 求解部分积分的结果
    y=bj(i,:)*imag(hz_f);
    y=-r_gauss*2*y/pi;
       
%------------------------------该子程序是用来计算部分积分结果的----------------------------%
end

function y=getkernel_hz(i)
% i代表要计算的行数，即Fi
    kx=x/tt;
% r_gauss是高斯积分时将下上限a，b转换到-1，1积分域时所产生的附加常数项
    r_gauss=dif_gauss(i)/x(i,:);    %dhzdt这里是除以时间tt,而hz这里是除以
% 计算所使用的n_gauss个自变量
    wt=kx(i,:);
% 计算频率域响应
    hz_f=hankel_Gups(wt,r,a,I0,h,z,n,econ,H,miu0);
% 求解部分积分的结果
    y=bj(i,:)*imag(hz_f);
    y=-r_gauss*2*y/pi;
       
%------------------------------该子程序是用来计算部分积分结果的----------------------------%
end
end