%该程序是关于书上计算预条件矩阵的程序；时间：2018.9.28；作者：曹华科；
% 输入：系数矩阵A；松弛因子w；方法k
% k=0是代表雅可比预条件，k=1时代表连续过松弛鎥(SSOR)，并且w=1时，SSOR变为高斯塞德尔预条件；
% 输出：预条件矩阵M；
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