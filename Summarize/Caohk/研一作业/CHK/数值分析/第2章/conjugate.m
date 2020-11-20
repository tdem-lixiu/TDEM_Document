%�ó����ǹ������ϳ�����̵Ĺ����ݶȷ�(conjugate gradient method)��ʱ�䣺2018.9.28�����ߣ��ܻ��ƣ�
% ���룺ϵ������A���۲�ֵ����b����ʼֵx0��
% �������x��
function x=conjugate(A,b,x0)
n=length(b);
if nargin==2
    x0=zeros(n,1);
end
x=x0;
d=b-A*x0;
r=d;
if r==0
    stop;
end
for k=1:1:n
    if norm(r,inf)<2.22e-16
        break;
    end
    ak=(r'*r)/(d'*A*d);
    x=x+ak*d;
    r1=r-ak*A*d;
    bk=(r1'*r1)/(r'*r);
    d=r1+bk*d;
    r=r1;
end 
k
end