% X代表收视率,bot代表底价,sale为计划销售价,goal为最高报价,y为最终报价
% ns为商家个数,ms为宣传费用
clc;
clear;
close all;
n=10000;
a=10;
ns=floor(8+92*rand(n,1));
ms=ns.^2.*0.001.*(1+0.5*rand(n,1));
X=0.1+2.9*rand(n,1);
bot=a*X.*(0.5+1.5*rand(n,1));
sale=(1+rand(n,1)).*bot;
goal=(sale-bot).*rand(n,1)+bot;
% 
y=bot+0.6*rand(n,1).*(goal-bot)+0.0001*bot.*ns;
for i=1:1:n
    if a*X(i)-y(i) > 0
        y(i)=y(i)+( a*X(i)-y(i) )*rand;
    end
    if sale(i) > y(i)
        y(i)=1.01*y(i);
    end
    if y(i) > goal(i)
        y(i) = goal(i);
    end
end
H=[ns ms X sale bot goal y];
save data4 ns ms X sale bot goal y