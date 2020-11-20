% ����6.6 ����-��������RK2���е㷽��
% ʹ��ydot.m����΢�ַ����Ҳຯ����ֵrhs
% ���룺����a��b����ֵ����y0������n
% �����ʱ�䲽������t����n*2�ľ���y��
% ʹ��ʽ����midp(0,1,[0 1],10)��
function [t,y]=midp(a,b,y0,n)
t(1)=a;y(1,:)=y0;
h=(b-a)/n;
for i=1:1:n
    t(i+1)=t(i)+h;
    y(i+1,:)=midpstep(t(i),y(i,:),h);
end

function z=midpstep(t,y,h)
z1=ydot(t,y);
g=y+h*z1/2;
z2=ydot(t+h/2,g);
z=y+h*z2;
end

function z=ydot(t,y)
z(1)=y(2)^2-2*y(1);
z(2)=y(1)-y(2)-t*y(2)^2;
end

end