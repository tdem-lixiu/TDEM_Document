% 7.1 打靶法试验第一题
function z=ff(s)
a=0;
b=1;
yb=exp(1)/3;
ydot=@(t,y) [y(2);y(1)+2*exp(t)/3];
[t,y]=ode45(ydot,[a,b],[0,s]);
z=y(end,1)-yb;
end