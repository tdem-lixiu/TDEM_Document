% ���ߣ��ܻ��ƣ�ʱ�䣺2019/05/28��
% ������λ��������ѧ��
% ��ʾ���ó����ǹ���ƫ΢�ֿγ̴���ҵ�ĵ�2�⣬����Crank-Nicolson��ʽ(��ʽ��ʽ)��������
% ����˵����x1,x2��x�ķ�Χ��x1�����ޣ�x2������;
%          tn��Ҫ�����ʱ��㣬���������飬��������n_tn��Ҫ�����ʱ�����
%          lamb������ȣ��˴�Ϊlamb=delt_t/(delt_x);
%          delt_x��x����Ĳ�����delt_t��ʱ�䲽����
%          n_t��ʱ�������ʷֵĸ�����n_x��x���������ʷֵĸ�����
%          u������ڵ��ϵĽ��ֵ��u_ana�������⡣
% �ӳ���˵�����޵����ӳ���
%%
clc;
clear all;
close all;
x1=0;  %x�ķ�Χ��x1�����ޣ�x2������
x2=1;
delt_x=1.d-1;  %x��ȡֵ���
tn=[0.01 0.05 0.10 ];    %�����ʱ���
lamb=0.1;   %lanb������ȣ��ڵڶ�������delt_t/(delt_x*delt_x)
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
    %-----������״���� start-----%
    Co_vec = -[2+2/lamb];
    Co_vec = repmat(Co_vec,[n_x-2 1]);
    Co=diag(Co_vec);   %CoΪϵ������
    Co1=diag(ones(n_x-3,1),-1);
    Co2=diag(ones(n_x-3,1),1);
    Co=Co+Co1+Co2;
    %------������״���� end------%
    
    %-----�����ұ����� start-----% 
    C= -u(i,(2:n_x-1)+1)+(2-2/lamb)*u(i,(2:n_x-1))-u(i,(2:n_x-1)-1);
    C=C.';
    %-----�����ұ����� end-----% 
    
    %------������õ�ÿ�ε�����ֵ end------%
    u(i+1,1)=0;
    u(i+1,n_x)=0;
    u(i+1,2:n_x-1)=Co\C;
    %------������õ�ÿ�ε�����ֵ end------%
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
    plot(x,result(i,:),x,u_ana(i,:),'o');
    hold on;
end
xlabel('X');
ylabel('u');
title('��2����ֵʵ��');
legend('0.01��ֵ��','0.01������','0.05��ֵ��','0.05������','0.10��ֵ��','0.10������');