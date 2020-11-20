% ����3.7 ʹ�ñ������������ߵ����ɻ��Ƴ���
% ��MATLAB��ͼ�δ����е���õ���һ����
% Ȼ���ٵ�����εõ��������Ƶ������һ�������㣬
% Ȼ�������ÿ��3�˵���õ����㣬���������Ӹ���Σ�
% ���»س�����ֹ����
function bezierdraw
plot([-1 1],[0 0],'k',[0 0],[1 -1],'k');
grid on;
hold on;
[x0,y0]=ginput(1);
t=0:0.01:1;
while 1
    [xnew,ynew]=ginput(3);
    if length(xnew)<3
        break;
    end
    x=[x0;xnew];
    y=[y0;ynew];
    [xb,yb]=bessel_curve(x,y,t);
    plot([x(1) x(2)],[y(1) y(2)],'b:o');
    plot([x(3) x(4)],[y(3) y(4)],'b:o');
    plot(xb,yb);
    grid on;
    hold on;
    x0=x(4);
    y0=y(4);   
end
hold off;