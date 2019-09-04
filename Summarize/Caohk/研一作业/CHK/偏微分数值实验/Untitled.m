clc;
clear;
close all;
%使用牛顿下山法求解第五题的解析解
delt_x=2.d-2;
x=(-50:50)*delt_x;
f=@(y,t,x) 0.5+sin( pi*(x-y*t) )-y;
df=@(y,t) -1-pi*t*cos(pi*y*t);
y0=1.0;
for i=1:1:1000
    y=y0-f(y0,0.324,x)./df(y0,0.324);
    y0=y;
end
plot(x,y0)