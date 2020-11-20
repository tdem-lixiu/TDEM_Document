% �˳���ʱ������Ԫ��LU�ֽ����(��ʹ����LU�ĸĽ��㷨)��ʱ�䣺2018.9.117�����ߣ��ܻ��ƣ�
% ���룺a��n*n��ϵ������
% �����L,U�Ǿ������LU�ֽ��õ����¡������Ǿ���,P���û�����
function [L,U,P]=sLU(a)
n=length(a);
eps=1.e-22;
for i=1:1:n
    if a(i,i)==0
        error('a(i,i)=0');
    end
end
L=eye(n);
U=zeros(n);
P=eye(n);
%�ֽ�Ϊ�¡������Ǿ��󲢴洢��a��
for j=1:1:n-1        %��
    if abs(a(j,j))<eps
        error('zero pivot encountered');
    end
    %��Ԫ����
    d=a(j,j);
    di=j;
    for i=j+1:1:n
        if abs(a(i,j))>abs(d)
            d=a(i,j);
            di=i;
        end
    end
    dsort(1:n)=a(di,1:n);
    a(di,1:n)=a(j,1:n);
    a(j,1:n)=dsort(1:n);
    Psort(1:n)=P(di,1:n);
    P(di,1:n)=P(j,1:n);
    P(j,1:n)=Psort(1:n);
    %��Ԫ����
    for i=j+1:1:n    %��
        h=a(i,j)/a(j,j);
        a(i,j)=h;
        for k=j+1:1:n
            a(i,k)=a(i,k)-a(j,k)*h;
        end
    end
end
%�ֽ�Ϊ�¡������Ǿ��󲢴洢��a��

%��a�е�LUԪ����ȡ����
for i=1:1:n
    for j=1:1:i-1
        L(i,j)=a(i,j);
    end
end
for i=1:1:n
    for j=i:1:n
        U(i,j)=a(i,j);
    end
end
%��a�е�LUԪ����ȡ����

end
