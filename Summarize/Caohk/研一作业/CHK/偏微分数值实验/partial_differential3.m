% 作者：曹华科；时间：2019/05/28；
% 工作单位：长安大学；
% 提示：该程序是关于偏微分课程大作业的第3题，关于第二类边界处理的线性偏微分方程的求解程序；
% 参数说明：flag：是不同方法的旗帜；flag=1为边界条件用中间差商代替微商,
%                 flag=2为左边边界条件用向前差商代替微商，右边边界条件用向后差商代替微商
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
flag=1;  %flag=1时中心差分格式处理边界条件，flag=2时前向、后向差分处理边界条件
x1=0;  %x的范围，x1是下限，x2是上限
x2=1;
delt_x=1.d-1;  %x的取值间隔
tn=[0.01 0.05 0.10 ];    %计算的时间点
lamb=2.5d-1;   %lanb是网格比，在第三题中是delt_t/(delt_x*delt_x)
delt_t=lamb*delt_x*delt_x;
n_tn=round(ceil(tn./delt_t)+1);  %向上取整
n_t=max(n_tn);
n_x=ceil( (x2-x1)/delt_x )+1;

u=zeros(n_t,n_x);
k=1;
result=zeros(length(tn),n_x);
%----- 给定初始值  start -----%
x=x1+delt_x*(0:n_x-1);
u(1,:)=1;
%----- 给定初始值  end   -----%
%-----  迭代  start -----%
if flag==1
    for i=1:1:n_t-1
        %-----给定边值 start-----%
        %左边边界
        u(i+1,1)=u(i,1)+lamb*( 2*u(i,2)-(2+2*delt_x)*u(i,1) );
        %右边边界
        u(i+1,n_x)=u(i,n_x)+lamb*( 2*u(i,n_x-1)-(2+2*delt_x)*u(i,n_x) );
        %------给定边值 end------%
        for j=2:1:n_x-1
            %计算该时间段类的内点的值
            u(i+1,j)=u(i,j)+lamb*( u(i,j+1)-2*u(i,j)+u(i,j-1) );
        end
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %保存第k计算的时间的数据
            k=k+1;
        end
    end
elseif flag==2
    for i=1:1:n_t-1
        for j=2:1:n_x-1
            %计算该时间段类的内点的值
            u(i+1,j)=u(i,j)+lamb*( u(i,j+1)-2*u(i,j)+u(i,j-1) );
        end
        %-----给定边值 start-----%
        %左边边界
        u(i+1,1)=u(i+1,2)/(1+delt_x);
        %右边边界
        u(i+1,n_x)=u(i+1,n_x-1)/(1+delt_x);
        %------给定边值 end------%
        if any( n_tn == i+1 )
            result(k,:)=u(i+1,:);   %保存第k计算的时间的数据
            k=k+1;
        end
    end
else
    disp('flag输入错误,请重新输入');
    return;
end
%-----  迭代   end  -----%

%%
% 计算解析解
% 利用牛顿下山法求解Alpha start
n_a=100;   %计算的项数
a=1+((1:n_a)-1)*pi;
f=@(x) x.*tan(x)-0.5;
ff=@(x) tan(x)+x./cos(x)./cos(x);
for i=1:1:1000
    a=a-f(a)./ff(a);
end
% 利用牛顿下山法求解Alpha end
u_ana=zeros(length(tn),n_x);
for i=1:1:length(tn)
    for j=1:1:n_x
        u_ana(i,j) = 4*sum( 1./( 3+4*a.*a )./cos(a).* ...
        exp(-4*a.*a*tn(i)).*cos(2*a*(x(j)-0.5)) );
    end
end


%%
% 画图
for i=1:1:length(tn)
    plot(x,result(i,:),'o',x,u_ana(i,:),'-');
    hold on;
end
xlabel('X');
ylabel('u');
title('第3道数值实验');
legend('0.01数值解','0.01解析解','0.05数值解','0.05解析解','0.10数值解','0.10解析解');