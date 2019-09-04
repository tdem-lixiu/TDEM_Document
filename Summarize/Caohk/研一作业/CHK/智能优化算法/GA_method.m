clc;
clear;
L=200;   %群体大小
n=10;    %个体基因数
Pc=0.8;  %交叉概率
Pm=0.4;  %变异概率
x_a=-1.28;  %x的下限
x_b=1.28;   %x的上限
n_iter=300;   %迭代次数
error_y=1.d-3;   %容忍误差值

x0=rand(n,L)*(x_b-x_a)+x_a;   %随机初始化，每一列代表一个个体，行数=基因数，列数=个体数
x=x0;
y1=fun(x0); 
[temp,y_pos]=sort(y1);            %记录最优历史位置
ymin(1)=temp(1);                  %记录历史最优值          
y_x=x0(:,y_pos(1));
n_best=1;    %第n个最优值
mseq(1)=0;
%%
for i=1:1:n_iter
%     进行选择操作  start
    Pi=(temp(end)-y1)/(temp(end)-temp(1));      %计算他们适应度
    Pi=Pi/(sum(Pi));
    Pi=cumsum(Pi);   %制作轮盘
    P=rand(1,L);  
    for j=1:1:L
        for k=1:1:L
            if rank(1,1) <= Pi(k)
                x(j)=x0(k);
            end
        end
    end
%     进行选择操作  end 
%     x是经过选择复制的新群体,x0是上次迭代中的旧群体

%  进行交叉操作 start
n_Pc=floor(Pc*L/2);
rand_Pc=randperm(L);   %随机打乱顺序排列
for k=1:1:n_Pc
    rand_Pcpos=unidrnd(n-1); %随机选取染色体交换位置
    x(1:rand_Pcpos,rand_Pc(k))=x(1:rand_Pcpos,rand_Pc(k+n_Pc));
    x(rand_Pcpos:end,rand_Pc(k+n_Pc))=x(rand_Pcpos:end,rand_Pc(k));
end
%  进行交叉操作 end

%  进行变异操作 start
for j=1:1:L
    for k=1:1:n
        if rand >= Pm
            x(k,j)=rand*(x_b-x_a)+x_a;
        end
    end
end
%  进行变异操作 end

%  计算适应度，并保留最佳值 start

y1=fun(x);             
[temp,y_pos]=sort(y1);                   %记录最优历史位置
% x(:,y_pos(end))=x0(:,1);
x0=x;
if(temp(1)<ymin(n_best))
    n_best=n_best+1;
    mseq(n_best)=i;
    ymin(n_best)=temp(1);                 %记录历史最优值 
    y_x(:,n_best)=x0(:,y_pos(1));         %记录历史最优解
end

%  计算适应度，并保留最佳值 end
if ymin(n_best)<=error_y
    break;
end  

end
%%
% 画图
i
if i>=n_iter
    disp('未达到精度要求');
else
    disp('达到精度要求并退出循环');
end
plot(mseq(1:end),ymin(1:end))
xlabel('迭代次数');
ylabel('函数值f(x)');
title('遗传算法');
str=strcat('最小值是',num2str(ymin(n_best)));
sk=strcat('最小值点在第',num2str(mseq(end)-1),'次迭代');
text(1,0.1,sk,'FontSize',12);
text(1,0.3,str,'FontSize',12);
disp('最小值是：')
ymin(n_best)
disp('最优解是：')
y_x(:,n_best).'
disp('最小值的迭代次数是');
mseq(end)-1
%%
% 目标函数
function result=fun(x)
[n1,~]=size(x);
x1=(1:n1);
result=x1*(x.^4)+rand(1,1);
end