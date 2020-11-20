% �˳����ǹ������ظ�˹��ȥ����ʱ�䣺2018.9.15�����ߣ��ܻ��ƣ�
% ���룺����a�ǹ���Ԫ��ϵ����n*n����b�ǹ��ڹ۲�ֵ��1*n����
%       n�Ǿ����С
% �����c��1*n�ľ����
function c=gauss(a,b,n)
if nargin==2
    n=size(b);
end
eps=1.e-22;
c=b;

for i=1:1:n
    if a(i,i)==0
        error('a(i,i)=0');
    end
end

%���ø�˹��ȥ����ϵ������Ϊ�����Ǿ���
for j=1:1:n-1        %��
    if abs(a(j,j))<eps
        error('zero pivot encountered');
    end
    for i=j+1:1:n    %��
        h=a(i,j)/a(j,j);
        for k=j+1:1:n
            a(i,k)=a(i,k)-a(j,k)*h;
        end
        b(i)=b(i)-h*b(j);
    end
end
%���ø�˹��ȥ����ϵ������Ϊ�����Ǿ���

%�ⷽ��
for i=n:-1:1
    c(i)=0;
    for j=n:-1:i+1
        c(i)=c(i)-a(i,j)*c(j);
    end
    c(i)=(c(i)+b(i))/a(i,i);
end
%�ⷽ��

end