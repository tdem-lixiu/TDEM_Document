% �ó����ǹ������ϵĳ���˹��(Cholesky)�ֽ�ĳ���ʱ�䣺2018.9.28�����ߣ��ܻ��ƣ�
% ���룺��Ҫ�ֽ����������A��
% ������ֽ��ľ���R��
function R=cholesky(A)
n=length(A);
R=zeros(n);
B=zeros(n);
u=zeros(n,1);
for i=1:1:n
    if A(i,i)<0 || A(i,i)==0
        error('the matrix is not positive');
    end
    B=0;
    a=sqrt(A(i,i));
    A(i,i)=0;
    R(i,i)=a;
    u=0;
    for j=i+1:1:n
        u(j)=A(j,i)/a;
        A(j,i)=0;
        A(i,j)=0;
        R(i,j)=u(j);       
    end
    A=A-u'*u;
end
end