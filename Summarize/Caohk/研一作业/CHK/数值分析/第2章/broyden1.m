% ����2.3 Broyden������ʱ�䣺2018.9.29�����ߣ��ܻ��ƣ�
% ���룺��ʼ����x0�������k����ʼ����a
% �������x
% ʹ��ʾ����broyden1(f,[1;1],10)
function x=broyden1(f,x0,k,a)
[n,m]=size(x0);
if nargin==3
    a=eye(n,n);
end
for i=1:1:k
    s=sgauss(a,-f(x0));
    x=x0+s;
    del=x-x0;delta=f(x)-f(x0);
    a=a+(delta-a*del)*del'/(del'*del);
    x0=x;
end
end