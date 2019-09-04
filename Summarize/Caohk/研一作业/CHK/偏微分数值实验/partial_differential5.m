% ���ߣ��ܻ��ƣ�ʱ�䣺2019/05/28��
% ������λ��������ѧ��
% ��ʾ���ó����ǹ���ƫ΢�ֿγ̴���ҵ�ĵ�5�⣬���ڷ�����ƫ΢�ַ��̵�������
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
flag=3;  %flag=1Ϊӭ���ʽ,flag=2ΪLax-Friedrichs��ʽ��flag=3ΪLax-Wendroff��ʽ
x1=-1;  %x�ķ�Χ��x1�����ޣ�x2������
x2=1;
delt_x=2.d-2;  %x��ȡֵ���
tn=[0.552];    %�����ʱ���,ע�⣬Ϊ�����ۣ�������ø�һ��ֵ
lamb=0.8;   %lanb������ȣ��ڵ�һ������delt_t/(delt_x)
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
    u(1,i) = 0.5+sin(x(i)*pi);  %t=0ʱ�ĳ�ֵ����
end
%----- ������ʼֵ  end   -----%
%-----  ����  start -----%
if flag==1
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            u(i+1,j)=u(i,j)-lamb/2*( u(i,j)*u(i,j)-u(i,j-1)*u(i,j-1) );
            %-----������ֵ start-----%
            u(i+1,n_x)=u(i,n_x)-lamb/2*( u(i,n_x)*u(i,n_x)-u(i,n_x-1)*u(i,n_x-1) );
            u(i+1,1)=u(i+1,n_x);  % ���������ں����������֮��ҲӦ������ͬ���ڵ����ں���!!
            %------������ֵ end------%
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %�����k�����ʱ�������
            k=k+1;
        end
    end
elseif flag==2  %Lax-Friedrichs��ʽ
    f=@(u) u.*u/2;   %������f�Ĳ���  �ο�����154ҳ
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            u(i+1,j)=0.5*( (u(i,j-1)+u(i,j+1)) - lamb*( f(u(i,j+1))-f(u(i,j-1)) ) );
            %-----������ֵ start-----%
            u(i+1,n_x)=0.5*( (u(i,n_x-1)+u(i,2)) - lamb*( f(u(i,2))-f(u(i,n_x-1)) ) );
            u(i+1,1)=u(i+1,n_x);  % ���������ں����������֮��ҲӦ������ͬ���ڵ����ں���!!
            %------������ֵ end------%
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %�����k�����ʱ�������
            k=k+1;
        end
    end    
elseif flag==3  %Lax-Wendroff��ʽ
    f=@(u) u.*u/2;   %������f�Ĳ���  �ο�����154ҳ
    a=@(u) u;   %������f�ĵ�������
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            u(i+1,j)=u(i,j)-lamb/2*( f(u(i,j+1))-f(u(i,j-1)) )+ ...
                lamb*lamb/2*(  a((u(i,j)+u(i,j+1))/2) * ( f(u(i,j+1))-f(u(i,j)) ) - ...
                a((u(i,j-1)+u(i,j))/2) * ( f(u(i,j))-f(u(i,j-1)) )  );
            %-----������ֵ start-----%
            u(i+1,n_x)=u(i,n_x)-lamb/2*( f(u(i,2))-f(u(i,n_x-1)) )+ ...
                lamb*lamb/2*(  a((u(i,n_x)+u(i,2))/2) * ( f(u(i,2))-f(u(i,n_x)) ) - ...
                a((u(i,n_x-1)+u(i,n_x))/2) * ( f(u(i,n_x))-f(u(i,n_x-1)) )  );
            u(i+1,1)=u(i+1,n_x);  % ���������ں����������֮��ҲӦ������ͬ���ڵ����ں���!!
            %------������ֵ end------%
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
% �����ſɱȵ�����������������
f=@(y,t,x) 0.5+sin( pi*(x-y*t) )-y;
df=@(y,t) -1-pi*t*cos(pi*y*t);
u_ana=zeros(length(tn),n_x);
for i=1:1:length(tn)
    y0=1.0;
    for j=1:1:100
        y=y0-f(y0,tn(i),x)./df(y0,tn(i));
        y0=y;
    end
    u_ana(i,:)=y0;
end

%%
% ��ͼ
for i=1:1:length(tn)
    plot(x,result(i,:))%,x,u_ana(i,:),'-');
    hold on;
end
xlabel('X');
ylabel('u');
title('��5����ֵʵ��');
legend('0.552��ֵ��','0.552������');
