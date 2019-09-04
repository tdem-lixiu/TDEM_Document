% 该程序为层次分析法
clc;
clear;
close all;
A=[1 1/5 1/7 1/6 1/5;
   5 1 1/2 1 1;
   7 2 1 1 1
   6 1 1 1 1
   5 1 1 1 1];

% 平均随机一致性指标由已知资料搜索给出
RI=[0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];
n=length(A);
SumA=zeros(n,1);
for i=1:1:n
    SumA(i)=1;
    for j=1:1:n
        SumA(i)= SumA(i)*A(i,j);
    end
end
SumA=SumA.^(1.0/3);
SumA=SumA/(sum(SumA));
W1=A*SumA;
W=W1/sum(W1);
[~,H]=eig(A);
Hm=0;
for i=1:1:n
    Hm=max(Hm,H(i,i)); %求最大特征值
end
V=Hm;
CI=(V-n)/(n-1);
CR=CI/RI(n);
disp('W =');disp(W)
disp('CR =');disp(CR)
if CR<=0.1
    disp('一致性可接受');
else 
    disp('一致性不可接受');
end
