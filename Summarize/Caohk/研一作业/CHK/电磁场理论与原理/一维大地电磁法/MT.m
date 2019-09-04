% MT一维正演
% 注意：角频率选取不应太大，否则会产生极大值而出现误差或无值
clear;
clc;
h=[8.d1 4.d3 1.d20];cond=[0.04 0.01 0.1];
miu0=4.d-7*pi;
w=wsamp(1.d-4,1.d6,101);
Z=Z_Cal(w,cond,miu0,h);
resist=abs(Z(:,1)).*abs(Z(:,1))./(w(:)*miu0);
%%
% 画图
plot(log10(w),log10(resist)','ko');
% axis square;
grid on;
xlabel('角频率 (rad/s)');
ylabel('视电阻率 (Ω·m');
title('MT一维正演');