%�ó����ǹ������ϼ���Ԥ��������ĳ���ʱ�䣺2018.9.28�����ߣ��ܻ��ƣ�
% ���룺ϵ������A���ɳ�����w������k
% k=0�Ǵ����ſɱ�Ԥ������k=1ʱ�����������ɳ��x(SSOR)������w=1ʱ��SSOR��Ϊ��˹���¶�Ԥ������
% �����Ԥ��������M��
function M=pre(A,w,k)
n=length(A);
L=zeros(n);
U=zeros(n);
D=zeros(n);
if nargin==2
    k=0;
end
if k==0
    M=diag(diag(A));
end
if k==1
    D=diag(diag(A));
    for i=1:1:n
        for j=1:1:i-1
            L(i,j)=A(i,j);
        end
        for j=i+1:1:n
            U(i,j)=A(i,j);
        end
    end
    M=(D+w*L)*inv(D)*(D+w*U);
end
end