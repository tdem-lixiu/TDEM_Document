% gasuss_seidel�ǹ��ڸ�˹���¶�����������ʱ�䣺2018.9.18�����ߣ��ܻ��ƣ�
% ���룺A��ϵ������b�ǹ۲�ֵ����a�ǳ�ʼֵ,eps�Ǳ仯����С����ֵ
% �����x�����յĵ��������k��������������ǳ����ڲ����Ƶ����Ĳ�����
function x=gseidel(A,b,a,eps)
n=length(A);
if nargin==3
    eps=2.22e-16;
end
if nargin==2
    eps=2.22e-16;
    a(1:n,1)=0;
end
L=zeros(n);
D=b;
U=zeros(n);
for i=1:1:n
    for j=1:1:i-1
        L(i,j)=A(i,j);
    end
    for j=n:-1:i+1
        U(i,j)=A(i,j);
    end 
    D(i)=A(i,i);
end
for i=1:1:n
    Asum=0;
    for j=1:1:n
        Asum=Asum+abs(L(i,j))+abs(U(i,j));
    end
    if Asum>abs(D(i)) || Asum==abs(D(i))
        error('the matrix is not diagonally dominant');
    end
end
x1=a;
x=b;
k=0;
while abs(x1-x)>eps
    if k>100
        break;
    end
    k=k+1;
    x=x1;
    for i=1:1:n
        x1(i)=(b(i)-L(i,1:n)*x1-U(i,1:n)*x1)/D(i);
    end
end
k
x=x1;
end