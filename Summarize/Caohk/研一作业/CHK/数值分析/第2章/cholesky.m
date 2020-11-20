% 该程序是关于书上的楚列斯基(Cholesky)分解的程序；时间：2018.9.28；作者：曹华科；
% 输入：需要分解的正定矩阵A；
% 输出：分解后的矩阵R；
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