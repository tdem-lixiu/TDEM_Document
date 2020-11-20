%  f=@(x)det([1 2 3 x;4 5 x 6; 7 x 8 9;x 10 11 12])-1000;
%  c=bisection(f,-20,0,0.5e-6)
%  x=-1:0.01:3;
%  y=2.*x.^3-6.*x-1;
%  plot(x,y);


% 1.3实验 第3题
% h=fzero(@(x) 2*x*cos(x)-2*x+sin(x^3),[-0.1,0.2])
% f=@(x) 2*x*cos(x)-2*x+sin(x^3);
% c=bisection(f,-0.1,0.2)

% 1.3实验 第5题
%  h=fzero(@(x) (x-1)*(x-2)*(x-3)*(x-4)-1.e-6*x^6,4.0)

% 1.4 牛顿法 第5题
% f=@(x) 3.141592653*(2/3*x^3+10*x^2)-400;
% c=newton(f,2,1.0e-8);
% c=vpa(c,12)

% 1.4实验 第7题
%   x=-2:0.001:2;
%   f=@(x) exp(sin(x)^3)+x^6-2*x^4-x^3-1;
%   plot(x,exp(sin(x).^3)+x.^6-2.*x.^4-x.^3-1);
%   ylim([0,0.01]);
%   c=newton (f,1.5,1.e-10)
  
  
%   1.4实验 第11题
%    f=@(x) (15+1.36/(x^2))*(x-0.003183)-0.0820578*320;
%    c=newton(f,0.1,1.e-10)

% 1.4实验 第13题
%    x=-2:0.001:2;
%    f=@(x) (1-(3./(4.*x))).^(1/3);
%    plot(x,f(x));
%  ylim([0,1]);
%    c=newton (f,0.74,1.e-10) %因为不可微，所以得不到结果


% 割线法1.5 例题1.16
% h=@(x) x^3+x-1;
% c=secant(h,0,1,1.e-8);
% c=vpa(c,12)


% Brenk方法例题
% f=@(x) x^3+x-1;
% fzero(f,[0,1],optimset('Display','iter'))

%1.5实验 第3题
% f=@(x) exp(x)+sin(x)-4;
% x=0:0.01:2;
% plot(x,f(x));
% c=IQI(f,0,2,1,1.e-8);
% fzero(f,[0,2],optimset('Display','iter'))
% c=vpa(c)

% Stewart平台的前向动力系统实验
pi=3.141592635;
ezplot(@stewart,[-pi,pi])
c=stewart(pi/4)
h=newton(@stewart,2,1.e-5)
