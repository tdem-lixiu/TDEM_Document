% 该程序为问题4的神经网络算法
clc;
clear;
close all;
load data4.mat ns ms X sale bot goal y
f1=0.004*ns+0.004*ms+0.242*X+0.269*sale+0.271*bot+0.270*goal;
f2=0.505*ns+0.505*ms-0.004*X-0.004*sale-0.005*bot-0.003*goal;
H=[f1 f2 y];
save data5.mat H 
%%
pt=H;
%---------------输入数据矩阵---------------%
p=pt(:,1:2).'; 
%----------------目标数据矩阵--------------
t=pt(:,3).';     
%------------原始样本归一化-------------%
[P,minp,maxp,T,mint,maxt]=premnmx(p,t);
%------------创建一个新的前向神经网络 ------------%
net=newff(minmax(P),[8,1],{'tansig','purelin'},'traingdx');
%------------设置训练参数--------------------%
net.trainFcn='trainrp';
net.trainParam.show=50;
net.trainParam.lr=0.01;
net.trainParam.epochs=2000;
net.trainParam.goal=1e-3 ;
%------------调用traingdm算法训练BP网络-------------------%
[net,tr]=train(net,P,T);
%--------------对BP网络进行仿真----------------%
A=sim(net,P);
a=postmnmx(A,mint,maxt);
%-------------------------------------

%-----------------验证测试----------------%
x=p(:,4);   %输入格式为每个个体为一个列向量
% %--------------计算预测值------------%
x=tramnmx(x,minp,maxp);
Ax=sim(net,x);
% %--------------反归一化------------------%
Ax=postmnmx(Ax,mint,maxt);
x=postmnmx(x,minp,maxp);
Ax
save a_net net minp maxp mint maxt
