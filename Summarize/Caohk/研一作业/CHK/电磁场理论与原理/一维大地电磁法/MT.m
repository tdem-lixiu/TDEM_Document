% MTһά����
% ע�⣺��Ƶ��ѡȡ��Ӧ̫�󣬷�����������ֵ������������ֵ
clear;
clc;
h=[8.d1 4.d3 1.d20];cond=[0.04 0.01 0.1];
miu0=4.d-7*pi;
w=wsamp(1.d-4,1.d6,101);
Z=Z_Cal(w,cond,miu0,h);
resist=abs(Z(:,1)).*abs(Z(:,1))./(w(:)*miu0);
%%
% ��ͼ
plot(log10(w),log10(resist)','ko');
% axis square;
grid on;
xlabel('��Ƶ�� (rad/s)');
ylabel('�ӵ����� (����m');
title('MTһά����');