% ����3.1 ţ�ٲ��̲�ֵ�Ľ����������ߣ��ܻ��ƣ�ʱ�䣺2018��9��29�գ�
% ����ţ�ٲ��̷��������ʽ��ϵ��
% ���룺x��y�ǰ���n�����ݵ��x��y�����������
% way��������way=0ʱ�Ǽ�������ϵ������way=1�Ǹ���ϵ������
% �����Ƕ����ʽ�Ĳ�ֵ����ʽϵ��c��
% ʹ��nest.m�����ֵ����ʽ
% ע�⣺����ĵ����������һ�����飬ÿ�θ���һ����
function [c,v]=newtdd(x,y,m,way)
n=length(x);
if nargin==2
    way=0;
end
if way==0
    for i=1:1:n
        v(i,1)=y(i);
    end
    for i=2:1:n
        for j=1:1:n+1-i
            v(j,i)=(v(j,i-1)-v(j+1,i-1))/(x(j)-x(j+i-1));
        end
    end
    
    for i=1:1:n
        c(i)=v(1,i);
    end
end
if way==1
    v=m;
    v(n,1)=y(n);
    for i=2:1:n
        v(n-i+1,i)=(v(n-i+2,i-1)-v(n-i+1,i-1))/(x(n)-x(n-i+1));
    end
    c(1:n)=v(1,1:n);
end

end