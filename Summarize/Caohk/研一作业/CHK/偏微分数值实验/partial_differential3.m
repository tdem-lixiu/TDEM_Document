% ���ߣ��ܻ��ƣ�ʱ�䣺2019/05/28��
% ������λ��������ѧ��
% ��ʾ���ó����ǹ���ƫ΢�ֿγ̴���ҵ�ĵ�3�⣬���ڵڶ���߽紦�������ƫ΢�ַ��̵�������
% ����˵����flag���ǲ�ͬ���������ģ�flag=1Ϊ�߽��������м���̴���΢��,
%                 flag=2Ϊ��߽߱���������ǰ���̴���΢�̣��ұ߽߱������������̴���΢��
%          x1,x2��x�ķ�Χ��x1�����ޣ�x2������;
%          tn��Ҫ�����ʱ��㣬���������飬��������n_tn��Ҫ�����ʱ�����
%          lamb������ȣ��˴�Ϊlamb=delt_t/(delt_x);
%          delt_x��x����Ĳ�����delt_t��ʱ�䲽����
%          n_t��ʱ�������ʷֵĸ�����n_x��x���������ʷֵĸ�����
%          u������ڵ��ϵĽ��ֵ��u_ana�������⡣
% �ӳ���˵�����޵����ӳ���
%%
clc;
clear;
close all;
flag=1;  %flag=1ʱ���Ĳ�ָ�ʽ����߽�������flag=2ʱǰ�򡢺����ִ���߽�����
x1=0;  %x�ķ�Χ��x1�����ޣ�x2������
x2=1;
delt_x=1.d-1;  %x��ȡֵ���
tn=[0.01 0.05 0.10 ];    %�����ʱ���
lamb=2.5d-1;   %lanb������ȣ��ڵ���������delt_t/(delt_x*delt_x)
delt_t=lamb*delt_x*delt_x;
n_tn=round(ceil(tn./delt_t)+1);  %����ȡ��
n_t=max(n_tn);
n_x=ceil( (x2-x1)/delt_x )+1;

u=zeros(n_t,n_x);
k=1;
result=zeros(length(tn),n_x);
%----- ������ʼֵ  start -----%
x=x1+delt_x*(0:n_x-1);
u(1,:)=1;
%----- ������ʼֵ  end   -----%
%-----  ����  start -----%
if flag==1
    for i=1:1:n_t-1
        %-----������ֵ start-----%
        %��߽߱�
        u(i+1,1)=u(i,1)+lamb*( 2*u(i,2)-(2+2*delt_x)*u(i,1) );
        %�ұ߽߱�
        u(i+1,n_x)=u(i,n_x)+lamb*( 2*u(i,n_x-1)-(2+2*delt_x)*u(i,n_x) );
        %------������ֵ end------%
        for j=2:1:n_x-1
            %�����ʱ�������ڵ��ֵ
            u(i+1,j)=u(i,j)+lamb*( u(i,j+1)-2*u(i,j)+u(i,j-1) );
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %�����k�����ʱ�������
            k=k+1;
        end
    end
elseif flag==2
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            %�����ʱ�������ڵ��ֵ
            u(i+1,j)=u(i,j)+lamb*( u(i,j+1)-2*u(i,j)+u(i,j-1) );
        end
        %-----������ֵ start-----%
        %��߽߱�
        u(i+1,1)=u(i+1,2)/(1+delt_x);
        %�ұ߽߱�
        u(i+1,n_x)=u(i+1,n_x-1)/(1+delt_x);
        %------������ֵ end------%
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %�����k�����ʱ�������
            k=k+1;
        end
    end
else
    disp('flag�������,����������');
    return;
end
%-----  ����   end  -----%

%%
% ���������
% ����ţ����ɽ�����Alpha start
n_a=100;   %���������
a=1+((1:n_a)-1)*pi;
f=@(x) x.*tan(x)-0.5;
ff=@(x) tan(x)+x./cos(x)./cos(x);
for i=1:1:1000
    a=a-f(a)./ff(a);
end
% ����ţ����ɽ�����Alpha end
u_ana=zeros(length(tn),n_x);
for i=1:1:length(tn)
    for j=1:1:n_x
        u_ana(i,j) = 4*sum( 1./( 3+4*a.*a )./cos(a).* ...
        exp(-4*a.*a*tn(i)).*cos(2*a*(x(j)-0.5)) );
    end
end


%%
% ��ͼ
for i=1:1:length(tn)
    plot(x,result(i,:),'o',x,u_ana(i,:),'-');
    hold on;
end
xlabel('X');
ylabel('u');
title('��3����ֵʵ��');
legend('0.01��ֵ��','0.01������','0.05��ֵ��','0.05������','0.10��ֵ��','0.10������');