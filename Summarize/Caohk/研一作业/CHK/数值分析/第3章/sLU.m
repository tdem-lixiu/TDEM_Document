% 此程序时关于主元的LU分解程序(即使关于LU的改进算法)；时间：2018.9.117；作者：曹华科；
% 输入：a是n*n的系数矩阵
% 输出：L,U是矩阵进行LU分解后得到的下、上三角矩阵,P是置换矩阵；
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
%分解为下、上三角矩阵并存储在a中
for j=1:1:n-1        %列
    if abs(a(j,j))<eps
        error('zero pivot encountered');
    end
    %主元换行
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
    %主元换行
    for i=j+1:1:n    %行
        h=a(i,j)/a(j,j);
        a(i,j)=h;
        for k=j+1:1:n
            a(i,k)=a(i,k)-a(j,k)*h;
        end
    end
end
%分解为下、上三角矩阵并存储在a中

%将a中的LU元素提取出来
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
%将a中的LU元素提取出来

end
