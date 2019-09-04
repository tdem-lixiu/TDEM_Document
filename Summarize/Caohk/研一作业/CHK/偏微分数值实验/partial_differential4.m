% 作者：曹华科；时间：2019/05/28；
% 工作单位：长安大学；
% 提示：该程序是关于偏微分课程大作业的第4题，关于变系数线性偏微分方程的求解程序；
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
flag=2;
x1=0;  %x的范围，x1是下限，x2是上限
x2=2;
delt_x=10.d-2;  %x的取值间隔
tn=[0.1 0.5 1.0];    %计算的时间点
lamb=1.0;   %lanb是网格比，在第一题中是delt_t/(delt_x)
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
    if delt_x*(i-1) >= 0.2 && delt_x*(i-1) <= 0.4
        u(1,i) = 1.0;  %t=0时的初值条件
    else
        u(1,i) = 0.0;
    end
end
%----- 给定初始值  end   -----%
%-----  迭代  start -----%
if flag==1
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            %-----给定边值 start-----%
            u(i+1,1)=0.0;
            %------给定边值 end------%
            a=( 1+x(j)*x(j) )/( 1+2*x(j)*delt_t*(i-1)+2*x(j)*x(j)+x(j)^4 );
            u(i+1,j)=u(i,j)-lamb*a*( u(i,j)-u(i,j-1) );
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %保存第k计算的时间的数据
            k=k+1;
        end
    end
elseif flag==2
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            %-----给定边值 start-----%
            u(i+1,1)=0.0;
            u(i+1,n_x)=0.0;  %对于边界根据已知条件可给与0处理
            %------给定边值 end------%
            a=( 1+x(j)*x(j) )/( 1+2*x(j)*delt_t*(i-1)+2*x(j)*x(j)+x(j)^4 );
            u(i+1,j)=(  (u(i,j+1)+u(i,j-1))-lamb*a*( u(i,j+1)-u(i,j-1) )  )/2;
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %保存第k计算的时间的数据
            k=k+1;
        end
    end
elseif flag==3
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            %-----给定边值 start-----%
            u(i+1,1)=0.0;
            u(i+1,n_x)=0.0;  %对于边界根据已知条件可给与0处理
            %------给定边值 end------%
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
% 画图
for i=1:1:length(tn)
    plot(x,result(i,:),'-',x,u_ana(i,:),'-');
    hold on;
end
xlabel('X');
ylabel('u');
title('第四道数值实验');
legend('0.1数值解','0.1解析解','0.5数值解','0.5解析解','1.0数值解','1.0解析解');
