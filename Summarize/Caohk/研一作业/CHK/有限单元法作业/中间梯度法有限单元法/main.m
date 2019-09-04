clc;
clear;
close all;
k=[0.004758 0.0407011 0.1408855 0.393225 1.0880380];
g=[0.0099472 0.0381619 0.0980327 0.2511531 0.7260814];
I0=1;   %电流大小
x=(0:200)*0.1;   %x的坐标
y=(0:-1:-10)*0.1;   %y的坐标
nx=length(x);  %x方向的点数
ny=length(y);  %y方向的点数
n_point=nx*ny;  %总共节点点数
I= (nx-1)*(ny-1);  %单元数
n_source=(ceil((ny)/2)-1)*(nx-1)+1;
source=[n_source];  %给定源所在的单元，并以第1节点作为源的位置；
E0=1;
[I_point,I_xy]=Poufen(x,y);   %只适用于矩形的线性剖分
cond=[1 0.01];
n_cond=length(cond);
I_normal=[754+10*(0:50) 755+10*(0:50) 756+10*(0:50)];
% I_normal=[3+10*(0:nx-2) 4+10*(0:nx-2) 5+10*(0:nx-2) 6+10*(0:nx-2) 7+10*(0:nx-2) 8+10*(0:nx-2) 9+10*(0:nx-2) 10+10*(0:nx-2)]; %I_normal有n行，即代表有n个异常
I_cond=Fuyu(cond,I_normal,I); %I_cond存储着每个单元的电导率
a=zeros(1,I);
b=zeros(1,I);
for i=1:1:I
    a(i)=I_xy(1,I_point(4,I))-I_xy(1,I_point(1,I));   %计算每个单元的边长
    b(i)=I_xy(2,I_point(1,I))-I_xy(2,I_point(2,I));
end
n_x=length(x);
n_y=length(y);
I_bound_left=(1:n_y-1);  %给出左边界的单元,根据需要进行修改
I_bound_right=(I-n_y+2:I);  %给出右边界的单元，根据需要进行修改
I_bound_bottom=(ny-1)*(1:nx-1);   %给出底边界的单元，根据需要进行修改
K1=Inside1(I,I_cond,a,b);   %构建每个单元的K矩阵
Ue=0;
for i=1:1:length(k)
    Ke=0;
    P=zeros(n_point,1);
    K2=Inside2(I,I_cond,a,b,k(i));   %构建每个单元的K矩阵
    K3=Inside3(I,I_cond,k(i),source,I_point,I_xy,I_bound_left,I_bound_right,I_bound_bottom); 
    P(I_point(1,source))=0.5;
    Ke=Unit_syn(K1,K2,K3,I,I_point);  %单元合成
    Ue=Ue+Ke\P*g(i);
end
u=Ue(1:ny:n_point);
K_mn=1.0;
[ps,x_u]=trsps(u,K_mn,x,I0);
plot(x,u)
title('点电源电场');
xlabel('x');
ylabel('U');


