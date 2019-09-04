% 作者：曹华科；时间：2019/05/28；
% 工作单位：长安大学；
% 提示：该程序是关于偏微分课程大作业的第1题，关于显式差分格式的求解程序；
% 参数说明：x1,x2：x的范围，x1是下限，x2是上限;
%          tn：要计算的时间点，可以是数组，行向量；n_tn：要计算的时间个数
%          lamb：网格比，此处为lamb=delt_t/(delt_x);
%          delt_x：x方向的步长；delt_t：时间步长；
%          n_t：时间网格剖分的个数；n_x：x方向网格剖分的个数；
%          u：网格节点上的结果值；u_ana：解析解。
% 子程序说明：无调用子程序；
clc;
clear;
close all;
x1=0;  %x的范围，x1是下限，x2是上限
x2=1;
delt_x=1.d-1;  %x的取值间隔
tn=[0.10 0.50 1.0];    %计算的时间点
lamb=1.0;   %lanb是网格比，在第一题中是delt_t/(delt_x*delt_x)
delt_t=lamb*delt_x*delt_x;
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
    if delt_x*(i-1) >= 0. && delt_x*(i-1) < 0.5
        u(1,i) = 2*x(i);  %t=0时的初值条件
    else
        u(1,i) = 2*(1-x(i));
    end
end
%----- 给定初始值  end   -----%
%-----  迭代  start -----%
for i=1:1:n_t-1
    for j=2:1:n_x-1
        %-----给定边值 start-----%
        u(i+1,1)=0.0;
        u(i+1,n_x)=0.0;
        %------给定边值 end------%
        u(i+1,j)=u(i,j)+lamb*( u(i,j+1)-2*u(i,j)+u(i,j-1) ); 
    end
    if any( n_tn == i+1 )
        result(k,:)=u(i+1,:);   %保存第k计算的时间的数据
        k=k+1;
    end
end
%-----  迭代   end  -----%

%%
% 计算解析解 
n_ana=100;    %计算前100项来近似解析解
u_ana=zeros(length(tn),n_x);
for i=1:1:length(tn)
    for j=1:1:n_x
        u_ana(i,j) = 8/(pi*pi)*sum( sin(pi*(1:n_ana)/2).* ...
        sin((1:100)*pi*x(j)).*exp(-(1:n_ana).*(1:n_ana)*pi*pi*tn(i))./(1:n_ana)./(1:n_ana) );
    end
end

%%
% 画图
for i=1:1:length(tn)
    figure(1)
    plot(x,result(i,:),'o',x,u_ana(i,:),'-');
    hold on;
end
figure(1)
xlabel('X');
ylabel('u');
title('第一道数值实验');
legend('0.01数值解','0.01解析解','0.05数值解','0.05解析解','0.10数值解','0.10解析解');
% legend('0.10数值解','0.10解析解');
% figure(2)
% xlabel('X');
% ylabel('误差%');
% title('第一道数值实验误差图');
% legend('0.01误差','0.05误差','0.10误差');