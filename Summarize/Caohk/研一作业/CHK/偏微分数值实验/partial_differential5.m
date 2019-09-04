% 作者：曹华科；时间：2019/05/28；
% 工作单位：长安大学；
% 提示：该程序是关于偏微分课程大作业的第5题，关于非线性偏微分方程的求解程序；
% 参数说明：flag：是不同方法的旗帜；flag=1为迎风格式,
%                 flag=2为Lax-Friedrichs格式，flag=3为Lax-Wendroff格式
%          x1,x2：x的范围，x1是下限，x2是上限;
%          tn：要计算的时间点，可以是数组，行向量；n_tn：要计算的时间个数
%          lamb：网格比，此处为lamb=delt_t/(delt_x);
%          delt_x：x方向的步长；delt_t：时间步长；
%          n_t：时间网格剖分的个数；n_x：x方向网格剖分的个数；
%          u：网格节点上的结果值；u_ana：解析解。
% 子程序说明：无调用子程序；
%%
clc;
clear;
close all;
flag=3;  %flag=1为迎风格式,flag=2为Lax-Friedrichs格式，flag=3为Lax-Wendroff格式
x1=-1;  %x的范围，x1是下限，x2是上限
x2=1;
delt_x=2.d-2;  %x的取值间隔
tn=[0.552];    %计算的时间点,注意，为了美观，这里最好给一个值
lamb=0.8;   %lanb是网格比，在第一题中是delt_t/(delt_x)
delt_t=lamb*delt_x;
n_tn=round(ceil(tn./delt_t)+1);  %向上取整
n_t=max(n_tn);
n_x=ceil( (x2-x1)/delt_x )+1;
x=zeros(n_x,1);
u=zeros(n_t,n_x);
k=1;
result=zeros(length(tn),n_x);
%----- 给定初始值  start -----%
for i=1:1:n_x
    x(i)=x1+delt_x*(i-1);
    u(1,i) = 0.5+sin(x(i)*pi);  %t=0时的初值条件
end
%----- 给定初始值  end   -----%
%-----  迭代  start -----%
if flag==1
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            u(i+1,j)=u(i,j)-lamb/2*( u(i,j)*u(i,j)-u(i,j-1)*u(i,j-1) );
            %-----给定边值 start-----%
            u(i+1,n_x)=u(i,n_x)-lamb/2*( u(i,n_x)*u(i,n_x)-u(i,n_x-1)*u(i,n_x-1) );
            u(i+1,1)=u(i+1,n_x);  % 由于是周期函数，其迭代之后也应该是相同周期的周期函数!!
            %------给定边值 end------%
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %保存第k计算的时间的数据
            k=k+1;
        end
    end
elseif flag==2  %Lax-Friedrichs格式
    f=@(u) u.*u/2;   %拟线性f的部分  参考书上154页
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            u(i+1,j)=0.5*( (u(i,j-1)+u(i,j+1)) - lamb*( f(u(i,j+1))-f(u(i,j-1)) ) );
            %-----给定边值 start-----%
            u(i+1,n_x)=0.5*( (u(i,n_x-1)+u(i,2)) - lamb*( f(u(i,2))-f(u(i,n_x-1)) ) );
            u(i+1,1)=u(i+1,n_x);  % 由于是周期函数，其迭代之后也应该是相同周期的周期函数!!
            %------给定边值 end------%
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %保存第k计算的时间的数据
            k=k+1;
        end
    end    
elseif flag==3  %Lax-Wendroff格式
    f=@(u) u.*u/2;   %拟线性f的部分  参考书上154页
    a=@(u) u;   %拟线性f的导数部分
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            u(i+1,j)=u(i,j)-lamb/2*( f(u(i,j+1))-f(u(i,j-1)) )+ ...
                lamb*lamb/2*(  a((u(i,j)+u(i,j+1))/2) * ( f(u(i,j+1))-f(u(i,j)) ) - ...
                a((u(i,j-1)+u(i,j))/2) * ( f(u(i,j))-f(u(i,j-1)) )  );
            %-----给定边值 start-----%
            u(i+1,n_x)=u(i,n_x)-lamb/2*( f(u(i,2))-f(u(i,n_x-1)) )+ ...
                lamb*lamb/2*(  a((u(i,n_x)+u(i,2))/2) * ( f(u(i,2))-f(u(i,n_x)) ) - ...
                a((u(i,n_x-1)+u(i,n_x))/2) * ( f(u(i,n_x))-f(u(i,n_x-1)) )  );
            u(i+1,1)=u(i+1,n_x);  % 由于是周期函数，其迭代之后也应该是相同周期的周期函数!!
            %------给定边值 end------%
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %保存第k计算的时间的数据
            k=k+1;
        end
    end    
else
    disp('flag输入错误，请重新输入flag');
    return;
end
%-----  迭代   end  -----%

%%
% 计算解析解 
% 利用雅可比迭代法进行求解解析解
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
% 画图
for i=1:1:length(tn)
    plot(x,result(i,:))%,x,u_ana(i,:),'-');
    hold on;
end
xlabel('X');
ylabel('u');
title('第5道数值实验');
legend('0.552数值解','0.552解析解');
