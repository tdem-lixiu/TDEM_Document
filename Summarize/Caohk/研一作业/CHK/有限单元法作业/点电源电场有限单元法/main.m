clc;
clear;
close all;
I0=1;   %������С
x=(0:50);   %x������
y=(0:-1:-10);   %y������
nx=length(x);  %x����ĵ���
ny=length(y);  %y����ĵ���
n_point=nx*ny;  %�ܹ��ڵ����
I= (nx-1)*(ny-1);  %��Ԫ��
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
I_bound_left=(1:n_y-1);  %������߽�ĵ�Ԫ,������Ҫ�����޸�
I_bound_right=(I-n_y+2:I);  %�����ұ߽�ĵ�Ԫ��������Ҫ�����޸�   
K=Inside(I,I_cond,a,b);   %����ÿ����Ԫ��K����
P=Bound(I,I_cond,a,b,I_bound_left,I_bound_right,E0);  %����ÿ����Ԫ�ķǱ߽�ϵ������P
[Ke,Pe]=Unit_syn(K,P,I,I_point);  %��Ԫ�ϳ�
u=Ke\Pe;
U_P=u(1:ny:n_point);
K_mn=-1.0;
[ps,x_u]=trsps(U_P,K_mn,x,I0);
plot(x_u,-1.0.*ps)
title('�м��ݶȷ�');
xlabel('x')
ylabel('�ӵ�����');



