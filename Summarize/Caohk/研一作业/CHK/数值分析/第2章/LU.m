% 此程序是关于LU分解的；时间：2018.9.15；作者：曹华科；
% 输入：a是n*n的系数矩阵
% 输出：L,U是矩阵进行LU分解后得到的下、上三角矩阵
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
%分解为下、上三角矩阵
for j=1:1:n-1        %列
    if abs(a(j,j))<eps
        error('zero pivot encountered');
    end
    for i=j+1:1:n    %行
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
%分解为下、上三角矩阵

for i=1:1:n
    L(i,i)=1;
    U(1,i)=a(1,i);
end

end