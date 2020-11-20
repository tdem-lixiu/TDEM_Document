% �˳����ǹ���LU�ֽ�ģ�ʱ�䣺2018.9.15�����ߣ��ܻ��ƣ�
% ���룺a��n*n��ϵ������
% �����L,U�Ǿ������LU�ֽ��õ����¡������Ǿ���
function [L,U]=LU(a)
n=length(a);
eps=1.e-8;
for i=1:1:n
    if a(i,i)==0
        error('a(i,i)=0');
    end
end
L=zeros(n);
U=zeros(n);
%�ֽ�Ϊ�¡������Ǿ���
for j=1:1:n-1        %��
    if abs(a(j,j))<eps
        error('zero pivot encountered');
    end
    for i=j+1:1:n    %��
        h=a(i,j)/a(j,j);
        L(i,j)=h;
        for k=j+1:1:n
            a(i,k)=a(i,k)-a(j,k)*h;
        end
    end
    for i=j:1:n-1
        U(j+1,i+1)=a(j+1,i+1);
    end
end
%�ֽ�Ϊ�¡������Ǿ���

for i=1:1:n
    L(i,i)=1;
    U(1,i)=a(1,i);
end

end