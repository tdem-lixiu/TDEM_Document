% 此程序是根据p59的简化二维的stewart平台运动学的计算程序
% 输入：theta角度；
% 输出：out此时运动方程的值
function out=stewart(theta)
L1=3;
L2=3*sqrt(2);
L3=3;
pi=3.141592653;
r=pi/4;
p1=5;
p2=p1;
p3=3;
x1=5;
x2=0;
y1=0;
y2=6;
A2=L3.*cos(theta)-x1;
B2=L3.*sin(theta);
A3=L2.*cos(theta+r)-x2;
B3=L2.*sin(theta+r)-y2;
N1=B3.*(p2.^2-p1.^2-A2.^2-B2.^2)-B2.*(p3.^2-p1.^2-A3.^2-B3.^2);
N2=-A3*(p2.^2-p1.^2-A2.^2-B2.^2)+A2.*(p3.^2-p1.^2-A3.^2-B3.^2);
D=2.*(A2.*B3-B2.*A3);
out=N1.^2+N2.^2-p1.^2.*D.^2;
x=N1./D;
y=N2./D;
u1=x;
u2=x+L2*cos(theta+r);
u3=x+L3*cos(theta);
v1=y;
v2=y+L2*sin(theta+r);
v3=y+L3*sin(theta);
% plot([u1 u2 u3 x],[v1 v2 v3 y],'r'); hold on
% plot([0 x1 x2],[0 0 y2],'bo')
end 