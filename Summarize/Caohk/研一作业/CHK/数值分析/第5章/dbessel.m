% 该函数是计算双贝塞尔函数的程序；作者：曹华科；时间：2018.10.15；
% 参考文献：《双重贝塞尔函数积分的数值计算》、《正余弦的数值滤波算法》、《数值分析》中的辛普森积分
% 输入：a是第一类一阶贝塞尔函数的非积分变量，b是第一类零阶贝塞尔函数的非积分变量，
%       并且a,b必须是大于0；
%       f是要求的积分函数的句柄；
%       x*g是核函数除以自变量(值得注意的是,该函数必须是衰减的,即当变量趋于无穷时它趋于0),
%       g是函数句柄,x是贝塞尔函数积分变量；
% 输出：h是积分结果；
% 问题：待完善计算一阶和一阶的双贝塞尔函数
function h=dbessel(a,b,f,g,way)
%----------------------------------- 求解双beseel积分 -------------------------%
% 数值积分关于H1n,1
% clc;    %试验使用参数
% clear;  %试验使用参数
% a=4;    %试验使用参数
% b=1;    %试验使用参数
format long;
% 求解第一类积分区域的积分上下限
x0=0;
xmin=min(a,b);
m0=10;   %积分的截止x坐标值
x1=m0/xmin;   
% 求解第一类积分区域的积分上下限
% f=@(x) besselj(1,a.*x).*besselj(0,b.*x); %试验使用参数
n=8*(ceil(a*b*x1)+1)*2;  %计算需要划分的辛普森积分的子区间
% 利用辛普森积分计算第一类积分结果
y1=cnc(f,x0,x1,n,2);

% 计算第二类积分
filter_n=250;   %选取的是250位正余弦的滤波系数
delt=log(10)/20;  %计算位移步长
if way==0
k1=a+b;      %余弦k值
k2=a-b;
cos_sign=-1;
sin_sign=1;  
end
if way==1
    k1=a-b;
    k2=a+b;
    cos_sign=1;
    sin_sign=-1;
end

if b>a && way==0
    k2=b-a;      %正弦k值
    sin_sign=-1;
end

if b>a && way==1
    k1=b-a;      %余弦k值
    cos_sign=-1;
end

n1=floor(log(k1*x1)/delt)+150;   %余弦起始滤波n值
n2=floor(log(k2*x1)/delt)+150;   %正弦起始滤波n值

x_cos(1:filter_n-n1+1)=exp(delt.*((n1:filter_n)-150))./k1; %余弦起始滤波坐标值
x_sin(1:filter_n-n2+1)=exp(delt.*((n2:filter_n)-150))./k2; %正弦起始滤波坐标值

% g(x)代表核函数
% g=@(x) 1.d0./x;    %试验使用参数
% g(x)代表核函数

% 计算重叠的积分区域
gc_ol=@(x) 1./(pi*sqrt(a*b)).*cos(x.*k1).*g(x);
gs_ol=@(x) 1./(pi*sqrt(a*b)).*sin(x.*k2).*g(x);
   %将重叠积分区域分成n_ol个子区间
nc_ol=ceil(x1*k1);     %将重叠积分区域分成n_ol个子区间
ns_ol=ceil(x1*k2);
   %将重叠积分区域分成n_ol个子区间
fc_ol=cnc(gc_ol,x_cos(1),x1,nc_ol,2)*cos_sign;
fs_ol=cnc(gs_ol,x_sin(1),x1,ns_ol,2)*sin_sign;
% 计算重叠的积分区域

% 对余弦函数部分进行求积运算
sc_cos=constant_cos;
sc_cos=sc_cos';
fc=1./(pi*sqrt(a*b)).*sqrt(pi/2)./k1.*(g(x_cos)*sc_cos(n1:filter_n))*cos_sign;  
% 对余弦函数部分进行求积运算
% 对正弦函数部分进行求积运算
sc_sin=constant_sin;
sc_sin=sc_sin';
fs=1./(pi*sqrt(a*b)).*sqrt(pi/2)./k2.*(g(x_sin)*sc_sin(n2:filter_n))*sin_sign;   
% 对正弦函数部分进行求积运算

%第二类积分区域结果(含重叠部分)
y2=fc+fs;
%第二类积分重叠区域结果
y3=fc_ol+fs_ol;
% h为最终结果
x1
x_sin(1)
x_cos(1)
y1
y2
y3
h=y1+y2-y3;
%----------------------------------- 求解双beseel积分 -------------------------%
end