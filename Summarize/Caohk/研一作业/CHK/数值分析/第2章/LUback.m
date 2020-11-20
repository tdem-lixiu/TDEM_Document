% 次程序是用于LU分解回代求取结果的程序；时间：2018.9.15；作者：曹华科；
% 输入：L,U下、上三角矩阵（n*n），b表示1*n的观测数据矩阵；
% 输出：c是1*n的结果矩阵
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