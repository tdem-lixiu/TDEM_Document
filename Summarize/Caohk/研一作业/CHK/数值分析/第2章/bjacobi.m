% �ó��������е��ſɱȷ�����ʱ�䣺2018.9.27�����ߣ��ܻ��ƣ�
% ���룺a��ϵ������b�ǹ۲�ֵ��k�ǵ���������
% �������x��
function x=bjacobi(a,b,k)
n=length(b);
d=diag(a);
r=a-diag(d);
x=zeros(n,1);
for j=1:1:k
    x=(b-r*x)./d;
end
end