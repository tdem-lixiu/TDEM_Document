% ����2.3 Broyden������
% ���룺��ʼ����x0�������k����ʼ����b��
% �������x
% ʹ��ʾ����broyden2(f,[1;1],10)
function x=broyden2(f,x0,k,b)
[n,m]=size(x0);
if nargin==3
    b=eye(n,n);
end
for i=1:1:k
    x=x0-b*f(x0);
    del=x-x0;delta=f(x)-f(x0);
    b=b+(del-b*delta)*del'*b/(del'*b*delta);
%         x(1)=pi/2;x(3)=0;x(4)=0;x(6)=0;
    x0=x;
end
end