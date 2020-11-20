% �γ���������LU�ֽ�ش���ȡ����ĳ���ʱ�䣺2018.9.15�����ߣ��ܻ��ƣ�
% ���룺L,U�¡������Ǿ���n*n����b��ʾ1*n�Ĺ۲����ݾ���
% �����c��1*n�Ľ������
function c=LUback(L,U,b)
n=length(b);
c=b;
for i=1:1:n
    for j=1:1:i-1
        b(i)=b(i)-L(i,j)*c(j);
    end
    c(i)=b(i);
end
for i=n:-1:1
    for j=n:-1:i+1
        c(i)=c(i)-U(i,j)*c(j);
    end
    c(i)=c(i)/U(i,i);
end
end 