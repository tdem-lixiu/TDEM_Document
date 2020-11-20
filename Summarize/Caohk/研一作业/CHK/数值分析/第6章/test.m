clear;
clc;
% pend(0,100,[pi/2 0],2000)
% z=oribt2(0,100,[2 0.2 2 -0.2],[0,-0.01,0,0.01],10000,10)
% 6.3 习题11
x1=-0.972;y1=0.243;
x1d=-0.466;y1d=-0.433;
z=oribt3(0,1000,[x1 x1d y1 y1d],[-x1 x1d -y1 y1d],[0.07 -2*x1d 0 -2*y1d],100000,20);
% 4阶龙格-库塔试验
% [t,y]=RK4(0,1,1,5)
% od45的可控步长试验
% opts=odeset('RelTol',1e-6);
% [t,y]=ode45(@f,[0 1],1,opts)
% plot(t,y,'ok')

% h=0.15;
% w(1)=0.5;
% tol=1d-4;
% n=3/h;
% t(1)=0;
% for i=1:1:n
% g=@(x) x+8*x*x-9*x*x*x;
% t(i+1)=t(i)+h;
% w(i+1)=w(i)+h*g(w(i));
% f=@(z,h,w) z-(9*h*z^3-8*h*z^2+(1-h)*z-w)/(27*h*z^2-16*h*z+1-h);
% % z=w(i+1);
% z0=w(i);
% z=f(z0,h,w(i));
% while abs(z-z0)>tol
%     z0=z;
%     z=f(z0,h,w(i));
%     
% end
% w(i+1)=z
% end
% plot(t,w,'o',t,w)


% % 7.1打靶法试验第一题
% sstar=fzero(@ff,[0.3,0.4]);
% y0=[0 sstar]; 

% 7.1打靶法试验第5题








