% 该程序为问题三的神经网络算法
clc;
clear;
close all;
load data2.mat;
pt=result;
%---------------输入数据矩阵---------------%
p=pt(:,1:12).'; 
%----------------目标数据矩阵--------------
t=pt(:,13:22).';     
%------------原始样本归一化-------------%
[P,minp,maxp,T,mint,maxt]=premnmx(p,t);
%------------创建一个新的前向神经网络 ------------%
net=newff(minmax(P),[20,10],{'tansig','purelin'},'traingdx');
%------------设置训练参数--------------------%
net.trainFcn='trainrp';
net.trainParam.show=50;
net.trainParam.lr=0.01;
net.trainParam.epochs=1000;
net.trainParam.goal=1e-3 ;
%------------调用traingdm算法训练BP网络-------------------%
[net,tr]=train(net,P,T);
%--------------对BP网络进行仿真----------------%
A=sim(net,P);
a=postmnmx(A,mint,maxt);
%-------------优化后输入层全职和阈值-------------%
% inputWeights = net.IW{1,1};
% inputbias = net.b{1};
%-------------优化后网络层权值和阈值--------------%
% layerWights=net.LW{2,1};
% layerbias=net.b{2};
%-------------------------------------
x=zeros(12,100);
%-----------------单个广告类型时的向量----------------%
%k代表的是第k类的广告，广告的排列顺序和列表中的顺序相同
k=10;  
h=zeros(12,1);
h(1:2)=1;
for i=1:10
    if i==k
        h(i+2)=1;
    end
end

for i=1:1:100
    x1(:,i)=[0.01*i;0;1;1;1;1;1;1;1;1;1;1];
end
h=repmat(h,1,100);
x1=x1.*h;
x2=x1;
x2(2,:)= 1;
x=[x1 x2];
%--------------计算预测值------------%
x=tramnmx(x,minp,maxp);
Ax=sim(net,x);
%--------------反归一化------------------%
Ax=postmnmx(Ax,mint,maxt);
x=postmnmx(x,minp,maxp);
%-------------将结果归一化到匹配度上-------------%
y=mapminmax(Ax,0,1);
Y=y(k,:);
X=x(1,:);
X=mapminmax(X,19,65);
plot(X(1:100),Y(1,1:100),'b',X(101:200),Y(1,101:200),'r--');
xlabel('年龄(岁)');
ylabel('匹配度');
axis([19 65 0 1]);
legend('男','女');
% -----计算各个年龄段的销售情况 start-----%
for i=1:1:100
    if X(i) <= 25
        k(1)=i;
    elseif X(i) <= 30
        k(2)=i;
    elseif X(i) <= 45
        k(3)=i;
    end
end
k1(1)=sum(Y(1:k(1)))/k(1);
k1(2)=sum(Y(k(1)+1:k(2)))/(k(2)-k(1));
k1(3)=sum(Y(k(2)+1:k(3)))/(k(3)-k(2));
k1(4)=sum(Y(k(3)+1:100))/(100-k(3));
disp('(男性)从小到大各个年龄段的销售情况为:');
disp(k1);
k2(1)=sum(Y(101:100+k(1)))/k(1);
k2(2)=sum(Y(101+k(1):100+k(3)))/(k(3)-k(1));
k2(3)=sum(Y(101+k(3):200))/(100-k(3));
disp('(女性)从小到大各个年龄段的销售情况为:');
disp(k2);
% -----计算各个年龄段的销售情况 start-----%

