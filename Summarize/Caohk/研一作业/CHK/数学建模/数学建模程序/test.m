% �ó����ǽ���Ԥ�⣬����������
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
% %--------------����Ԥ��ֵ------------%
x=tramnmx(x,minp,maxp);
Ax=sim(net,x);
% %--------------����һ��------------------%
Ax=postmnmx(Ax,mint,maxt);
x=postmnmx(x,minp,maxp);
err=abs(y-Ax)./y;
figure(1);
plot(Ax*0.5);
hold on;
plot(y*0.5);
legend('BP���','��ʵ���ļ�����');
axis([1 20 0 35]);
xlabel('��k�ξ���');
ylabel('���ĳɽ���');
figure(2);
plot(err);
axis([1 20 0 0.14]);
xlabel('��k�ξ���');
ylabel('���');