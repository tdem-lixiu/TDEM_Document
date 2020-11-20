% 程序3.7 使用贝塞尔样条曲线的自由绘制程序；
% 在MATLAB的图形窗口中点击得到第一个，
% 然后再点击三次得到两个控制点和另外一个样条点，
% 然后继续以每次3此点击得到三点，给曲线增加更多段，
% 按下回车键终止程序
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