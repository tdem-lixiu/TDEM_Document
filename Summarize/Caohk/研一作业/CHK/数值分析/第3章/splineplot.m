% ����3.6 ������������
% �����ݵ���㲢��������
% ���룺x,y���ݵ�������ÿ���л����ĵ���k
% ������ڻ������ϵ�x1,y1����ֵ��
function [x1,y1]=splineplot(x,y,k)
n=length(x);
coeff=sspline(x,y);
x1=[];y1=[];
for i=1:n-1
    xs=linspace(x(i),x(i+1),k+1);
    dx=xs-x(i);
    ys=coeff(i,4)*dx;
    ys=(ys+coeff(i,3)).*dx;
    ys=(ys+coeff(i,2)).*dx+coeff(i,1);
    x1=[x1;xs(1:k)'];
    y1=[y1;ys(1:k)'];
end
x1=[x1;x(end)];
y1=[y1;y(end)];
plot(x,y,'o',x1,y1);
grid on;
end