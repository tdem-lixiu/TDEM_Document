% ����6.3 ����ֵ�����ŷ������
% ʹ��ydot.m����΢�ַ����Ҳຯ����ֵrhs
% ���룺����a��b����ֵ����y0������n
% �����ʱ�䲽������t����n*2�ľ���y��
% ʹ��ʽ����euler(0,1,[0 1],10)��
function [t,y]=euler2(a,b,y0,n)
t(1)=a;y(1,:)=y0;
h=(b-a)/n;
for i=1:1:n
    t(i+1)=t(i)+h;
    y(i+1,:)=eulerstep(t(i),y(i,:),h);
end
t=t';
plot(t,y(:,1),t,y(:,2));

function y=eulerstep(t,y,h)
y=y+h*ydot(t,y);
end

function z=ydot(t,y)
z(1)=y(2)^2-2*y(1);
z(2)=y(1)-y(2)-t*y(2)^2;
end

end