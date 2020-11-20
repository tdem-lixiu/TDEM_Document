% ����5.2����Ӧ����
% ���㶨���ֵĽ���
% ���룺Matlab����f������[a0,b0]
% �ݲ�tolo
% way�ǻ��ַ�ʽ��ѡ��way=1�����λ��֣�way=2������ɭ����
% ��������ƶ�����
% �м����˵����mul_facto�ǻ��ַ�ʽ�ı������ӣ�c�ǻ�����������м������
%              app��������ļ�������
function [int,n_adap]=adapquad(f,a0,b0,tolo,way)
if nargin==4
    way=2;
end
if way==1
    mul_factor=3;
end
if way==2
%     mul_factor=15;
    mul_factor=10;
end
int=0;n=1;a(1)=a0;b(1)=b0;
tol(1)=tolo;
app(1)=trap(f,a,b,way);

n_adap=1;
while  n>0
    c=(a(n)+b(n))/2;
    oldapp=app(n);
    app(n)=trap(f,a(n),c,way);app(n+1)=trap(f,c,b(n),way);
    if abs(oldapp-app(n)-app(n+1))<mul_factor*tol(n)
        int=int+app(n)+app(n+1);
        n_adap=n_adap+1;
        n=n-1;
    else
        b(n+1)=b(n);b(n)=c;
        a(n+1)=c;
        tol(n)=tol(n)/2;tol(n+1)=tol(n);
        n_adap=n_adap+1;
        n=n+1;
    end
end

function s=trap(f,a,b,way)
    if way==1
        s=(f(a)+f(b))*(b-a)/2;
    end
    if way==2
        s=(f(a)+4*f((a+b)/2)+f(b))*(b-a)/6;
    end        
end
end
    