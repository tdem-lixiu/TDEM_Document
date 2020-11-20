% 该程序是用于生成大型稀疏矩阵；时间：2018.9.27；作者：曹华科；
% 输入：n是矩阵的大小；
% 输出：稀疏系数矩阵a，稀疏观测值b
function [a,b]=sparsesetup(n)
e=ones(n,1);
n2=n/2;
a=spdiags([-e e*3 -e],-1:1,n,n);
% c=spdiags(e/2,0,n,n);
% c=fliplr(c);
% a=a+c;
% a(n2,n2+1)=-1;
% a(n2+1,n2)=-1;
b=zeros(n,1);
b(1)=2.5;
b(n)=2.5;
b(2:n-1)=1.5;
b(n2:n2+1)=1;
end
