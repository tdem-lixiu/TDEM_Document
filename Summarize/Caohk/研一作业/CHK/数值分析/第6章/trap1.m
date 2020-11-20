% ����6.2 ����ֵ΢�ַ����������ʽ���η���
% ʹ��ydot.m����΢�ַ����Ҳຯ����ֵrhs
% ���룺����a��b����ֵy0������n
% �����ʱ�䲽t����y��
% ʹ��ʽ�������⣺6.10
function [y,t]=trap1(a,b,y0,n)
y(1)=y0;
t(1)=a;
h=(b-a)/n;
for i=1:1:n
    t(i+1)=t(i)+h;
    y(i+1)=trapstep(t(i),y(i),h);
end

function f=trapstep(t,y,h)
f=y+h*ydot(t,y,h)/2;
end

function z=ydot(t,y,h)
y1=t*y+t*t*t;
t1=t+h;
z=y1+t1*(y1*h+y)+t1*t1*t1;
end

end