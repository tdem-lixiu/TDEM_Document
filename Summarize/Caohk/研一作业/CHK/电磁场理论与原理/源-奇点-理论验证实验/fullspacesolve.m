clc;
clear;
h=5;
z=-2*h:0.01:h;
f=exp(-abs(h+z))
subplot(2,1,1);
plot(z,f)
title('ԭ�����仯ͼ');
grid on;
syms x
y=diff(exp(-abs(h+x)));

y2=@(x) -sign(x+5).*exp(-abs(x+5));
subplot(2,1,2);
plot(z,y2(z))
title('�����仯ͼ');
grid on;
