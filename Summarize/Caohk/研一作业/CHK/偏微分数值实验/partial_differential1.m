% ���ߣ��ܻ��ƣ�ʱ�䣺2019/05/28��
% ������λ��������ѧ��
% ��ʾ���ó����ǹ���ƫ΢�ֿγ̴���ҵ�ĵ�1�⣬������ʽ��ָ�ʽ��������
% ����˵����x1,x2��x�ķ�Χ��x1�����ޣ�x2������;
%          tn��Ҫ�����ʱ��㣬���������飬��������n_tn��Ҫ�����ʱ�����
%          lamb������ȣ��˴�Ϊlamb=delt_t/(delt_x);
%          delt_x��x����Ĳ�����delt_t��ʱ�䲽����
%          n_t��ʱ�������ʷֵĸ�����n_x��x���������ʷֵĸ�����
%          u������ڵ��ϵĽ��ֵ��u_ana�������⡣
% �ӳ���˵�����޵����ӳ���
clc;
clear;
close all;
x1=0;  %x�ķ�Χ��x1�����ޣ�x2������
x2=1;
delt_x=1.d-1;  %x��ȡֵ���
tn=[0.10 0.50 1.0];    %�����ʱ���
lamb=1.0;   %lanb������ȣ��ڵ�һ������delt_t/(delt_x*delt_x)
delt_t=lamb*delt_x*delt_x;
n_tn=round(ceil(tn./delt_t)+1);  %����ȡ��
n_t=max(n_tn);
n_x=ceil( (x2-x1)/delt_x )+1;
x=zeros(n_x,1);
u=zeros(n_t,n_x);
k=1;
result=zeros(length(tn),n_x);
%----- ������ʼֵ  start -----%
for i=1:1:n_x
    x(i)=x1+delt_x*(i-1);
    if delt_x*(i-1) >= 0. && delt_x*(i-1) < 0.5
        u(1,i) = 2*x(i);  %t=0ʱ�ĳ�ֵ����
    else
        u(1,i) = 2*(1-x(i));
    end
end
%----- ������ʼֵ  end   -----%
%-----  ����  start -----%
for i=1:1:n_t-1
    for j=2:1:n_x-1
        %-----������ֵ start-----%
        u(i+1,1)=0.0;
        u(i+1,n_x)=0.0;
        %------������ֵ end------%
        u(i+1,j)=u(i,j)+lamb*( u(i,j+1)-2*u(i,j)+u(i,j-1) ); 
    end
    if any( n_tn == i+1 )
        result(k,:)=u(i+1,:);   %�����k�����ʱ�������
        k=k+1;
    end
end
%-----  ����   end  -----%

%%
% ��������� 
n_ana=100;    %����ǰ100�������ƽ�����
u_ana=zeros(length(tn),n_x);
for i=1:1:length(tn)
    for j=1:1:n_x
        u_ana(i,j) = 8/(pi*pi)*sum( sin(pi*(1:n_ana)/2).* ...
        sin((1:100)*pi*x(j)).*exp(-(1:n_ana).*(1:n_ana)*pi*pi*tn(i))./(1:n_ana)./(1:n_ana) );
    end
end

%%
% ��ͼ
for i=1:1:length(tn)
    figure(1)
    plot(x,result(i,:),'o',x,u_ana(i,:),'-');
    hold on;
end
figure(1)
xlabel('X');
ylabel('u');
title('��һ����ֵʵ��');
legend('0.01��ֵ��','0.01������','0.05��ֵ��','0.05������','0.10��ֵ��','0.10������');
% legend('0.10��ֵ��','0.10������');
% figure(2)
% xlabel('X');
% ylabel('���%');
% title('��һ����ֵʵ�����ͼ');
% legend('0.01���','0.05���','0.10���');