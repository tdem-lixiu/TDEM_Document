% �˳���ʹ����ţ�ٷ�����ֵ��
% ���룺f���������x��ʼֵ��totalʹ�������ֵ,m�����ظ��������������֪�ɲ����벢Ĭ��Ϊ1��
%�м�ֵ��v�����f(x)�ĵ���ʱ���в�ּ���ļ�С���x��
% �����c������ֵ�㣻
%       k���ڲ����ֵ���������������
function c=newton(f,x,total,m)
k=0;
if nargin==3
    m=2;
end
if nargin==2
    m=2;
    total=2.22e-16;
end
if nargin==1
    m=2;
    total=2.22e-16;
    x=0;
end
while abs(f(x))>total
    if x==0
        v=1.e-12;
    else
        v=0.01*x;
    end   
    if k>100
        break;
    end
    k=k+1;
    x=x-(m-1)*f(x)/((f(x+v)-f(x))/v);
end
c=x;
k
end 