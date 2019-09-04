% 该程序是进行预测，误差分析程序
clc;
clear;
close;
x=[12.38;8.06];
load a_net.mat net minp maxp mint maxt;
load data5.mat H
x=H(1:20,1:2);
y=H(1:20,3);
x=x';
y=y';
% %--------------计算预测值------------%
x=tramnmx(x,minp,maxp);
Ax=sim(net,x);
% %--------------反归一化------------------%
Ax=postmnmx(Ax,mint,maxt);
x=postmnmx(x,minp,maxp);
err=abs(y-Ax)./y;
figure(1);
plot(Ax*0.5);
hold on;
plot(y*0.5);
legend('BP拟合','真实竞拍价数据');
axis([1 20 0 35]);
xlabel('第k次竞拍');
ylabel('竞拍成交价');
figure(2);
plot(err);
axis([1 20 0 0.14]);
xlabel('第k次竞拍');
ylabel('误差');