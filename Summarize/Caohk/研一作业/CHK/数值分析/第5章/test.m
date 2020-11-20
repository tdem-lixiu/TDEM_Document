% 微分误差分析
% clc;
% clear;
% h=10.^-(1:9);
% format long;
% f1=(exp(h)-exp(0))./h;
% f2=(exp(h)-exp(-h))./(2*h);
% f=exp(0);
% error1=f-f1
% error2=f-f2

% 符号运算
% clc;
% clear;
% syms x;
% f=sin(3*x);
% f1=diff(f)

% 5.1实验
% clc;
% clear;
% f=@(x) sin(x)-cos(x);
% h=10.^-(1:12);
% %f1=(f(h)-f(-h))./(2.*h);
% f1=(f(h)-f(0))./h;
% f2=1;
% plot(log10(h),log10(abs(f1-f2)));
% grid on;

% 5.5 实验
% clc;
% clear;
% h=10.^-(1:12);
% f=@(x) cos(x);
% f1=(f(h)+f(-h)-2.*f(0))./(h.*h);
% f2=-1;
% plot(log10(h),log10(abs(f1-f2)));
% grid on;

% 5.2实验
% clc;clear;
% f=@(x) 1./sqrt(x);
% a=1;
% b=0;
% n=1000;
% y=cnc(f,b,a,n,3)

% 求解双beseel积分
% 数值积分关于H1n,1
% clc;
% clear;
% format long;
% % a=1;
% b=1;
% x0=0;
% x1=10;
% k=6000;
% y2=zeros(1,k);
% time=zeros(1,200);
% for a=1:200
% f=@(x) besselj(1,a.*x).*besselj(0,b.*x);
% y1=cnc(f,x0,x1,1,2);
% y2(1)=abs(y1);
% for n=2:k
% y1=cnc(f,x0,x1,n,2);
% y2(n)=abs(y1);
% if abs(y2(n)-y2(n-1))<1.d-5*y2(n)
%     time(a)=n;
%     break;
% end
% end
% n
% end
% plot(1:200,time)
% grid on;



% %----------------------------------- 求解双beseel积分 -------------------------%
% % 数值积分关于H1n,1
% clc;
% clear;
% format long;
% a=2;
% b=1;
% % 求解第一类积分区域的积分上下限
% x0=0;
% xmin=min(a,b);
% x1=10/xmin;   
% % 求解第一类积分区域的积分上下限
% % c=25.0d0;
% f=@(x) besselj(1,a.*x).*besselj(0,b.*x);%x.*exp(-x.*x.*c.*c).*besselj(1,a.*x).*besselj(1,b.*x);
% n=8*(ceil(a*b*x1)+1)*2;
% y1=cnc(f,x0,x1,n,2);
% 
% filter_n=250;
% delt=log(10)/20;
% k1=a+b;      %余弦k值
% k2=a-b;
% sign=1;
% if b>a
% k2=b-a;      %正弦k值
% sign=-1;
% end
% n1=floor(log(k1*x1)/delt)+150;   %余弦起始滤波数      %修改
% n2=floor(log(k2*x1)/delt)+150;   %正弦起始滤波数
% x_cos(1:filter_n-n1+1)=exp(delt.*((n1:filter_n)-150))./k1;  %修改
% x_sin(1:filter_n-n2+1)=exp(delt.*((n2:filter_n)-150))./k2;
% x_cos(1)
% x_sin(1)
% x1
% 
% % g(x)代表核函数
% g=@(x) 1.d0./x; %exp(-x.*x.*c.*c);
% % g(x)代表核函数
% % 计算重叠的积分区域
% gc_ol=@(x) -1./(pi*sqrt(a*b)).*cos(x.*k1).*g(x);
% gs_ol=@(x) 1./(pi*sqrt(a*b)).*sin(x.*k2).*g(x).*sign;
%    %将重叠积分区域分成n_ol个子区间
% nc_ol=ceil(x1*k1);     %将重叠积分区域分成n_ol个子区间
% ns_ol=ceil(x1*k2);
%    %将重叠积分区域分成n_ol个子区间
% fc_ol=cnc(gc_ol,x_cos(1),x1,nc_ol,2);
% fs_ol=cnc(gs_ol,x_sin(1),x1,ns_ol,2);
% % 计算重叠的积分区域
% 
% % 对余弦函数部分进行求积运算
% sc_cos=constant_cos;
% sc_cos=sc_cos';
% fc=-1./(pi*sqrt(a*b)).*sqrt(pi/2)./k1.*g(x_cos)*sc_cos(n1:filter_n);  %1，n1
% % 对余弦函数部分进行求积运算
% % 对正弦函数部分进行求积运算
% sc_sin=constant_sin;
% sc_sin=sc_sin';
% fs=1./(pi*sqrt(a*b)).*sqrt(pi/2)./k2.*g(x_sin)*sc_sin(n2:filter_n)*sign;   %1，n2
% % 对正弦函数部分进行求积运算
% 
% %第二类积分区域结果(含重叠部分)
% y1
% y2=fc+fs
% %第二类积分重叠区域结果
% y3=fc_ol+fs_ol
% % h为最终结果
% h=y1+y2-y3
% %----------------------------------- 求解双beseel积分 -------------------------%

% 5.2 第7题
% clc;
% clear;
% format long;
% a=0;
% b=1; %pi/2;
% f=@(x) atan(x)./x; %(exp(x)-1)./sin(x); %x./sin(x);
% y=cnc(f,a,b,16,3);

% 5.4 试验
% clc;
% clear;
% format long;
% f=@(x) 1+sin(exp(3*x));
% [int,n]=adapquad(f,-1,1,0.005,2)

% 6.1 试验
% eeuler(0,1,1,10)