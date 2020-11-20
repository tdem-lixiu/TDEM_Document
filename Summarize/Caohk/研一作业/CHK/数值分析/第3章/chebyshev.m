% ����3.4 ���캯�����б�ѩ�����ߣ��ܻ��ƣ�ʱ�䣺2018��9��29�գ�
% ʹ��n�׶���ʽ���ƺ���
% ���룺f���������a��b���������䣻x���Ա�����n�ǽ�����
% �����������ƺ�����ֵ�����������ͼ�����ʵͼ���Լ���
function y=chebyshev(f,a,b,x,n)
if nargin==4
    n=9;
end
ni=n+1;  %��ֵ����
xi=(a+b)/2+(b-a)/2*cos((1:2:2*ni-1)*pi/(2*ni));
yi=f(xi);
c=newtdd(xi,yi);
y=nest(n,c,x,xi);
ytrue=f(x);
subplot(1,2,1);
plot(xi,yi,'o',x,y,'r:',x,ytrue,'b');grid on;
subplot(1,2,2);
plot(x,ytrue-y);grid on;
end