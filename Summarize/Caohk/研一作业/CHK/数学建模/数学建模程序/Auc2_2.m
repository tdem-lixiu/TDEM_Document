% �ó���Ϊ����4���������㷨
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
%---------------�������ݾ���---------------%
p=pt(:,1:2).'; 
%----------------Ŀ�����ݾ���--------------
t=pt(:,3).';     
%------------ԭʼ������һ��-------------%
[P,minp,maxp,T,mint,maxt]=premnmx(p,t);
%------------����һ���µ�ǰ�������� ------------%
net=newff(minmax(P),[8,1],{'tansig','purelin'},'traingdx');
%------------����ѵ������--------------------%
net.trainFcn='trainrp';
net.trainParam.show=50;
net.trainParam.lr=0.01;
net.trainParam.epochs=2000;
net.trainParam.goal=1e-3 ;
%------------����traingdm�㷨ѵ��BP����-------------------%
[net,tr]=train(net,P,T);
%--------------��BP������з���----------------%
A=sim(net,P);
a=postmnmx(A,mint,maxt);
%-------------------------------------

%-----------------��֤����----------------%
x=p(:,4);   %�����ʽΪÿ������Ϊһ��������
% %--------------����Ԥ��ֵ------------%
x=tramnmx(x,minp,maxp);
Ax=sim(net,x);
% %--------------����һ��------------------%
Ax=postmnmx(Ax,mint,maxt);
x=postmnmx(x,minp,maxp);
Ax
save a_net net minp maxp mint maxt
