% ���ߣ��ܻ��ƣ�ʱ�䣺2019/05/28��
% ������λ��������ѧ��
% ��ʾ���ó����ǹ���ƫ΢�ֿγ̴���ҵ�ĵ�4�⣬���ڱ�ϵ������ƫ΢�ַ��̵�������
% ����˵����flag���ǲ�ͬ���������ģ�flag=1Ϊӭ���ʽ,
%                 flag=2ΪLax-Friedrichs��ʽ��flag=3ΪLax-Wendroff��ʽ
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
flag=2;
x1=0;  %x�ķ�Χ��x1�����ޣ�x2������
x2=2;
delt_x=10.d-2;  %x��ȡֵ���
tn=[0.1 0.5 1.0];    %�����ʱ���
lamb=1.0;   %lanb������ȣ��ڵ�һ������delt_t/(delt_x)
delt_t=lamb*delt_x;
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
    if delt_x*(i-1) >= 0.2 && delt_x*(i-1) <= 0.4
        u(1,i) = 1.0;  %t=0ʱ�ĳ�ֵ����
    else
        u(1,i) = 0.0;
    end
end
%----- ������ʼֵ  end   -----%
%-----  ����  start -----%
if flag==1
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            %-----������ֵ start-----%
            u(i+1,1)=0.0;
            %------������ֵ end------%
            a=( 1+x(j)*x(j) )/( 1+2*x(j)*delt_t*(i-1)+2*x(j)*x(j)+x(j)^4 );
            u(i+1,j)=u(i,j)-lamb*a*( u(i,j)-u(i,j-1) );
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %�����k�����ʱ�������
            k=k+1;
        end
    end
elseif flag==2
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            %-----������ֵ start-----%
            u(i+1,1)=0.0;
            u(i+1,n_x)=0.0;  %���ڱ߽������֪�����ɸ���0����
            %------������ֵ end------%
            a=( 1+x(j)*x(j) )/( 1+2*x(j)*delt_t*(i-1)+2*x(j)*x(j)+x(j)^4 );
            u(i+1,j)=(  (u(i,j+1)+u(i,j-1))-lamb*a*( u(i,j+1)-u(i,j-1) )  )/2;
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %�����k�����ʱ�������
            k=k+1;
        end
    end
elseif flag==3
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            %-----������ֵ start-----%
            u(i+1,1)=0.0;
            u(i+1,n_x)=0.0;  %���ڱ߽������֪�����ɸ���0����
            %------������ֵ end------%
            a=( 1+x(j)*x(j) )/( 1+2*x(j)*delt_t*(i-1)+2*x(j)*x(j)+x(j)^4 );
            dfdx=@(x,t) (2*x)/(x^4 + 2*x^2 + 2*t*x + 1) - ...
            ((x^2 + 1)*(4*x^3 + 4*x + 2*t))/(x^4 + 2*x^2 + 2*t*x + 1)^2;
            dfdt=@(x,t) -(2*x*(x^2 + 1))/(x^4 + 2*x^2 + 2*t*x + 1)^2;
            u(i+1,j)=u(i,j)-a*lamb/2*(u(i,j+1)-u(i,j-1))+delt_t*delt_t/2* ...
                (  a*a*(u(i,j+1)-2*u(i,j)+u(i,j-1))/(delt_x*delt_x) - ...
                 dfdt(x(j),delt_t*(i-1))*(u(i,j+1)-u(i,j-1))/2/delt_x + ...
                 a*dfdx(x(j),delt_t*(i-1))*(u(i,j+1)-u(i,j-1))/2/delt_x );
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %�����k�����ʱ�������
            k=k+1;
        end
    end    
else
    disp('flag�����������������flag');
    return;
end
%-----  ����   end  -----%

%%
% ��������� 
u_ana=zeros(length(tn),n_x);
for i=1:1:length(tn)
    for j=1:1:n_x
        temp=x(j)-tn(i)/(1+x(j)*x(j));
        if temp>=0.2 && temp<=0.4
            u_ana(i,j)=1.0;
        else
            u_ana(i,j)=0.0;
        end
    end
end

%%
% ��ͼ
for i=1:1:length(tn)
    plot(x,result(i,:),'-',x,u_ana(i,:),'-');
    hold on;
end
xlabel('X');
ylabel('u');
title('���ĵ���ֵʵ��');
legend('0.1��ֵ��','0.1������','0.5��ֵ��','0.5������','1.0��ֵ��','1.0������');
