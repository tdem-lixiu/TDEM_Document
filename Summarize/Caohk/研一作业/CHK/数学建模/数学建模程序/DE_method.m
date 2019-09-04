% 该算法为问题4中的差分进化算法
%%
% 赋初值
clc;
clear;
close all;
warning off;
NP=100;   %群体大小
n=2;    %个体基因数
F0=0.5;   %变异算子
s1_a=1.0;  %对于市场分析可知;
s5_a=8;
s5_b=200;
n_iter=500;   %迭代次数
error_y=1.d-5;   %容忍误差值
number=0;     %计数器
% 广告商的预算s2,s3为预期销售额,s4为收视率，s5为商家个数,s1为底价
s2=20.85;
s3=27.94;
s4=2.075;
Ps=0.51;   %判断阈值
s1_b=(0.025*s2+0.002*s3+0.007*s4+0.496-Ps)/0.027;  %计算最大底价

% 初始化取值
%%
global net minp maxp mint maxt;
load a_net.mat net minp maxp mint maxt;  %读取神经网络
x(1,:)=rand(1,NP)*(s1_b-s1_a)+s1_a;   %随机初始化，每一列代表一个个体，行数=基因数，列数=个体数
x(2,:)=rand(1,NP)*(s5_b-s5_a)+s5_a;
v=rand(n,NP);
u=rand(n,NP);
u=x;
y1=fun(x); 
[temp,y_pos]=sort(y1);            %记录最优历史位置
ymin(1)=temp(1);                  %记录历史最优值          
y_x=x(:,y_pos(1));
n_best=1;    %第n个最优值
mseq(1)=0;
%%
for i=1:1:n_iter


% 变异操作 start
  for k=1:1:NP
      % 选择三个不同的个体，进行差分 start
      r=randperm(NP,4);
      r1=r(1);
      r2=r(2);
      r3=r(3);
      if r1==k
          r1=r(4);
      elseif r2==k
          r2=r(4);
      elseif r3==k
          r3=r(4);
      end
       % 选择三个不同的个体，进行差分 end
       % 计算自适应算子 start
       lamb=exp(1-n_iter/(n_iter-i+1));
       F=F0*2^(lamb);
       % 计算自适应算子 end
       v(:,k)=x(:,r(1))+F*( x(:,r(2)) - x(:,r(3)) );
  end      
% 变异操作 end

%  进行交叉操作 start
CR=0.5*(1+rand);
Ln=randi([1,n]);
for k=1:1:n
    if rand <= CR || k==Ln
        u(k,:)=v(k,:);
    else
        u(k,:)=x(k,:);
    end
end
%  进行交叉操作 end


% 进行边界处理 start
for j=1:1:NP
    if u(1,j)>s1_b
        u(1,j)=s1_b;
    elseif u(1,j)<s1_a
        u(1,j)=s1_a;
    end
    if u(2,j)>s5_b
        u(2,j)=s5_b;
    elseif u(2,j)<s5_a
        u(2,j)=s5_a;
    end
end
% 进行边界处理 end



%     进行选择操作  start
    y=fun(u);
    for k=1:1:NP
        if y(k) < y1(k)
            x(:,k) = u(:,k);
        end
    end
%     进行选择操作  end 
%     x是经过选择复制的新群体,u是上次迭代中的旧群体

%  计算适应度，并保留最佳值 start
y1=fun(x);            
[temp,y_pos]=sort(y1);                   %记录最优历史位置
if(temp(1)<ymin(n_best))
    temp(2)=ymin(n_best);
    n_best=n_best+1;
    mseq(n_best)=i;
    ymin(n_best)=temp(1);                 %记录历史最优值 
    y_x(:,n_best)=x(:,y_pos(1));         %记录历史最优解
end

%  计算适应度，并保留最佳值 end
if abs(temp(1)-temp(2))<=error_y   
    number=number+1;
    if number>=5
        break;
    end
else
    number=0;
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
plot(mseq(1:end),50-ymin(1:end))
xlabel('迭代次数');
ylabel('最大收益f(x)');
title('差分进化算法');
str=strcat('最小值是',num2str(ymin(n_best)));
sk=strcat('最小值点在第',num2str(mseq(end)-1),'次迭代');
text(1,3,sk,'FontSize',12);
text(1,1,str,'FontSize',12);
disp('最大收益是：')
disp(50-ymin(n_best))
disp('最优底价、最优所需宣传费是')
disp(y_x(1,n_best).')
disp((y_x(2,n_best)-8).^2*0.001);
y_x(2,n_best)
disp('最小值的迭代次数是');
disp(mseq(end)-1)
%%
% 目标函数
function result=fun(x)
% 广告商的预算s2,s3为预期销售额,s4为收视率，s5为商家个数,s1为底价
global net minp maxp mint maxt;
[~,n]=size(x);
Ax=zeros(1,n);
for i=1:1:n
mx=tramnmx(x(1,i),minp,maxp);
Bx=sim(net,mx);
Ax(i)=postmnmx(Bx,mint,maxt);
end
result=( Ax.*(1+x(2,:)/500) )  -( x(2,:)-8 ).^2*0.001;
result = 50-result;
end