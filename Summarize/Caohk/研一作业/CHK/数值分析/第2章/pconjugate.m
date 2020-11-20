%�ó����ǹ������ϵ�Ԥ���������ݶȷ�(conjugate gradient method)��ʱ�䣺2018.9.28�����ߣ��ܻ��ƣ�
% ���룺ϵ������A���۲�ֵ����b��Ԥ�����������M1����ʼֵx0��
% �������x��
function x=pconjugate(A,b,M1,x0)
n=length(b);
if nargin==3
    x0=zeros(n,1);
end
x=x0;
r=b-A*x0;
d=M1*r;
z=d;
if r==0
    exit;
end
for k=1:1:n
    if norm(r,inf)<2.22e-16
        break;
    end
    rz=r'*z;
    Ad=A*d;
    ak=(rz)/(d'*Ad);
    x=x+ak*d;
    r1=r-ak*Ad;
    z1=M1*r1;
    bk=(r1'*z1)/(rz);
    d=z1+bk*d;
    r=r1;
    z=z1;
end 
k
end