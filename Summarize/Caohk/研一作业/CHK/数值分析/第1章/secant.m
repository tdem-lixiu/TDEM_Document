% �ó����ǹ��ڸ��߷���ȡ��ֵ���
% ���룺f���������x0��x1�����ʼֵ��total�������ֵ��
% �����c������ֵ�㣬
%       k�ڲ��������ֵ���������������
function c=secant(f,x0,x1,total)
if nargin==3
    total=2.22e-16;
end 
if nargin==2 
    error('the number of input parameters is not satisfied');
end 
if nargin==1
    total=2.22e-16;
    x0=-1.5;
    x1=1;
end
k=1;
while abs(f(x1))>total
    if f(x1)==f(x0)
        error('f(x1)=f(x0)');
    end 
    if k>100
        break;
    end
    k=k+1;
    x2=x1-(f(x1)*(x1-x0))/(f(x1)-f(x0));
    x0=x1;
    x1=x2;
end 
c=x1;
k
end 