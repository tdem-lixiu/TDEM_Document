% ����Ƶ�ʲ�������
% ���룺a��b��Ƶ�ʵ������ޣ�
%       n�����ɵĲ���������
% �����t��ʱ���������
function t=tsamp(a,b,n)
%���ɶ�������ϵ�µĵȼ�����
delt=(log10(b)-log10(a))/(n-1);
t=zeros(1,n);
for i=1:1:n
    t(i)=10^(log10(a)+delt*(i-1));
end
end