% ����3.3 ����sin����������#1���ԣ����ߣ��ܻ��ƣ�ʱ�䣺2018��9��29�գ�
% ��3�׶���ʽ����sin���ߣ�
% ע�⣺��ʵ���Ȳ���
% ���룺x
% �����sin(x)�Ľ���
function y=sin1(x)
b=pi*(0:3)/6;yb=sin(b);
c=newtdd(b,yb);
s=1;
x1=mod(x,2*pi);
if x1>pi
    x1=2*pi-x1;
    s=-1;
end
if x1>pi/2
    x1=pi-x1;
end
y=s*nest(3,c,x1,b);
end
