% �ú���ʹ���ò�������������������ֵ��
% ���룺�������f����ʼֵa���ݲ�total��
% �Ƿ������ֵ����������k��
% �����������ֵ��c
function c=fixedpoint(f,a,total)
k=0;
if nargin==2
    total=1.e-10;
end
fa=f(a);
while abs(fa-a)>total
    a=fa;
    fa=f(a);
    k=k+1;
end
c=a;
k
end
    