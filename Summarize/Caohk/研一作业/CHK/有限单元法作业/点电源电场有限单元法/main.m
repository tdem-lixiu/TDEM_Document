clc;
clear;
close all;
I0=1;   %电流大小
x=(0:50);   %x的坐标
y=(0:-1:-10);   %y的坐标
nx=length(x);  %x方向的点数
ny=length(y);  %y方向的点数
n_point=nx*ny;  %总共节点点数
I= (nx-1)*(ny-1);  %单元数
E0=1;
[I,I_point,I_xy]=Poufen(x,y);
cond1=1;
cond2=0.1;
I_normal=[232:234,242:244,252:254,262:264,272:274];
I_cond=Fuyu(cond1,cond2,I_normal,I);
a=zeros(1,I);
b=zeros(1,I);
for i=1:1:I
    a(i)=I_xy(1,I_point(4,I))-I_xy(1,I_point(1,I));
    b(i)=I_xy(2,I_point(1,I))-I_xy(2,I_point(2,I));
end
n_x=length(x);
n_y=length(y);
I_bound_left=(1:n_y-1);  %给出左边界的单元,根据需要进行修改
I_bound_right=(I-n_y+2:I);  %给出右边界的单元，根据需要进行修改   
K=Inside(I,I_cond,a,b);   %构建每个单元的K矩阵
P=Bound(I,I_cond,a,b,I_bound_left,I_bound_right,E0);  %构建每个单元的非边界系数矩阵P
[Ke,Pe]=Unit_syn(K,P,I,I_point);  %单元合成
u=Ke\Pe;
U_P=u(1:ny:n_point);
K_mn=-1.0;
[ps,x_u]=trsps(U_P,K_mn,x,I0);
plot(x_u,-1.0.*ps)
title('中间梯度法');
xlabel('x')
ylabel('视电阻率');



