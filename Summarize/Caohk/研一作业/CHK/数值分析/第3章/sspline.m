% ��Ȼ����������ֵ�������ߣ��ܻ��ƣ�ʱ�䣺2018��10��9�գ�
% ���룺x������������y������������
% �����ϵ������
function A=sspline(x,y,way)
n=length(x);
xx(1:n-1,1)=x(2:n);
xx(n)=0;
x_dif=xx-x;
yy(1:n-1,1)=y(2:n);
yy(n)=0;
y_dif=yy-y;
c_b=zeros(n,1);
c_A=zeros(n);
if nargin==2
    way=1;
end
if way==1
    c_A(1,1)=1;    %��Ȼ������ֵ ͨ��������4ֵ���ܸı�ɷ���Ҫ�������������ֵ����
    c_A(n,n)=1;    %��Ȼ������ֵ  ֻ�޸�c_A(1,1)��c_A(n,n)�Լ�c_b�������ʵ����������� ��P156
    c_b(1)=0;      %��Ȼ������ֵ
    c_b(n)=0;      %��Ȼ������ֵ
end
% ǯ����������   ����v1����vn���Լ����õ����˵�ĵ���ֵ
if way==2
    c_A(1,1:2)=[2*x_dif(1) x_dif(1)];
    c_A(n,n-1:n)=[x_dif(n-1) 2*x_dif(n-1)];
    v1=0;vn=0;
    c_b(1)=3*(y_dif(1)/x_dif(1)-v1);
    c_v(n)=3*(vn-y_dif(n-1)/x_dif(n-1));
end
% ǯ����������
% ��������������
if way==3
    c_A(1,1:2)=[1 -1];
    c_A(n,n-1:n)=[1 -1];
    c_b(1)=0;
    c_b(n)=0;
end
% ��������������
% ��Ŧ����������
if way==4
    c_A(1,1:3)=[x_dif(2) -x_dif(1)-x_dif(2) x_dif(1)];
    c_A(n,n-2:n)=[x_dif(n-1) -x_dif(n-2)-x_dif(n-1) x_dif(n-2)];
    c_b(1)=0;
    c_b(n)=0;
end
% ��Ŧ����������
c_b(2:n-1,1)=3*(y_dif(2:n-1)./x_dif(2:n-1)-y_dif(1:n-2)./x_dif(1:n-2));
for k=2:1:n-1
    c_A(k,k-1:k+1)=[x_dif(k-1) 2*(x_dif(k)+x_dif(k-1)) x_dif(k)];
end
[c_L,c_U,c_P]=sLU(c_A);
c_b=c_P*c_b;
c=LUback(c_L,c_U,c_b);
d(1:n-1,1)=(c(2:n)-c(1:n-1))./(3*x_dif(1:n-1));
b(1:n-1,1)=y_dif(1:n-1)./x_dif(1:n-1)-x_dif(1:n-1).*(2*c(1:n-1)+c(2:n))/3;
A(n-1,4)=0;
for k=1:1:n-1
    A(k,1:4)=[y(k) b(k) c(k) d(k)];
end
end 