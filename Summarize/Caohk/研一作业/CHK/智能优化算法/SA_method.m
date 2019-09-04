% 日期：2019/03/02；作者：曹华科；程序：智能优化算法-模拟退火法-未优化
clc;
clear;
% Intelligent optimization algorithm 智能优化算法-模拟退火法-初级
% 初始化 start
t0=100;   %初始温度  %90
tn=0.01;      %冷却温度
atten=0.999; %温度衰减系数
n_t=5;      %多少次不变时退出外循环
n_L=5;      %多少次不变时退出内循环
L=500;      %内部最多循环次数
step=0.2;   %领域函数的步长 0.2
yz=1.d-3;   %容忍误差值
x_a=-1.28;  %x的下限
x_b=1.28;   %x的上限
n_x=20;     %x数值的大小
x0=rand(n_x,1)*(x_b-x_a)+x_a; %随机初始化x
% 初始化 end

%% 计算步骤
x=x0;
t=t0;
flag1=0;   % 内循环标志
flag2=0;   % 外循环标志
y(1)=fun(x); % 内循环的最优值
k=1;
f(1)=y(1);  % 外循环的最优值
kk=1;
tic;
while 1 
    if t<tn   %当低于最低温度，退出循环
       break;
    end
    %------------------------- 内循环 start -------------------------%
    for i=1:1:L    
        x_k=x+step*(rand(n_x,1)*(x_b-x_a)+x_a); % 进行Metropolis抽样
        
        %对超过界限的值进行处理 start
        for j=1:1:n_x
            if x_k(j)<x_a
                x_k(j)=x_a;
            elseif x(j)>x_b
                x_k(j)=x_b;
            end
        end
        %对超过界限的值进行处理 end
        
        % 等温过程 start
        y_m=fun(x_k);
        if y_m < y(k)
            k=k+1;
            y(k)=y_m;
            x=x_k;
            x_best=x;
        elseif exp( -(y_m-y(k))/t ) >=  rand
            x=x_k;
        end
        % 等温过程 end
        
        % 判断最优解是否达到稳定
        if k<=1
            
        elseif abs(y(k)-y(k-1)) <yz
            flag1=flag1+1;
        else
            flag1=0;
        end
        if flag1 >= 5
            break;
        end
    end
    %-------------------------- 内循环 end --------------------------%
    
    t=t*atten; %温度冷却,退温过程
    if y(k) < f(kk)
        kk=kk+1;
        f(kk)=y(k);
    end
    if kk<=1
        
    elseif abs(f(kk)-f(kk-1))<yz
        flag2=flag2+1;
    else
        flag2=0;
    end
    
    if flag2>=5
        break;
    end
    
end
toc;


%% 画图以及参数输出
t
if t<=0.01
    disp('未达到精度要求');
else
    disp('在最低温度之前达到精度要求');
end
plot(y(2:end))
xlabel('迭代次数');
ylabel('函数值f(x)');
title('模拟退火法');
str=strcat('最小值是',num2str(y(k)));
sk=strcat('最小值点在第',num2str(k-1),'次迭代');
text(0,10,sk,'FontSize',12);
text(0,4,str,'FontSize',12);
disp('最小值是：')
y(k)
disp('最优解是：')
x_best.'
disp('最小值的迭代次数是');
k-1

%%
% 目标函数
function result=fun(x)
n=length(x);
result=(1:n)*(x.^4)+rand;
end

