% �ó���������һ��bessel������һϵ�����ֵ
% �����ο�����Kerry Key�ġ�Is the fast Hankel transform faster than quadrature?���Ĵ���
% ʹ�÷��������õ��Ƿ�����ţ����ɽ��
% ���룺nu�ǽ�����
%       n�Ǽ������������
% ������������ֵx(Ϊ������)
% ע�����0<=nu<=10,0<n<=10����n��vӦΪ����
% �ô�����bessel�����ĵ����Ǵ��ڽ����ģ������Ƶ���bessel�����ĵ�����
function x=besselroot(nu,n)
%���ô��������������������µ�
%�ο����ף����Եġ���ѧ����������419ҳ
x=(1:n)'*pi+nu*pi/2-pi/4;
n_iter=10;   %����������
for k=1:1:n_iter
    y0=besselj(nu,x);
    y1=nu./x.*y0;
    y2=besselj(nu+1,x);
    %y1-y2�Ǹú����ĵ���
    h=-y0./(y1-y2);
    %����
    x=x+h;
    %�ж��Ƿ�ﵽ����Ҫ��
    if all(abs(h)<8*eps(x))
        break;
    end
end      
end