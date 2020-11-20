% ����6.1 ����ֵ�����ŷ������
% ʹ��ydot.m����΢�ַ����Ҳຯ����ֵrhs
% ���룺����a��b����ֵy0������n
% �����ʱ�䲽t����y��
% ʹ��ʽ����euler(0,1,1,10)��
function [t,y]=eeuler(a,b,y0,n)
t(1)=a;
y(1)=y0;
h=(b-a)/n;
for i=1:n
    t(i+1)=t(i)+h;
    y(i+1)=eulerstep(t(i),y(i),h);
end
plot(t,y)

function y=eulerstep(t,y,h)
y=y+h*ydot(t,y);
end

function z=ydot(t,y)
    z=t*y+t^3;
end
end