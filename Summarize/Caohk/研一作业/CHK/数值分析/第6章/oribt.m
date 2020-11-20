% 程序6.5 单体问题的画图程序；
% 输入：时间区间 a,b，初始条件
% ic=[x0 vx0 y0 vy0]，x的位置，x速度，y的位置，y速度；
% 步数n，每个画出点p的步数；
% 调用单步方法，诸如 trapstep.m
% 使用示例： orbit(0,100,[0 1 2 0],10000,5)
function z=oribt(a,b,ic,n,p)
h=(b-a)/n;
t(1)=a;
y(1,:)=ic;
sunx=0;suny=0;
set(gca,'xlim',[-5,5],'ylim',[-5,5], ...
        'xtick',(-5:5),'ytick',[-5:5], ...
        'Nextplot','add','Visible','on','Drawmode','fast');
cla;
axis square;
sun=line('color','r','Marker','.','markersize',50,...
         'xdata',[],'ydata',[],'erase','none');
head=line('color','g','Marker','.','markersize',25, ...
          'erase','xor','xdata',[],'ydata',[]);
tail=line('color','b','LineStyle','-','erase','none', ...
          'xdata',[],'ydata',[]);
% [px,py]=ginput(1);
% [px1,py1]=ginput(1);
% y(1,:)=[px px1-px py py1-py];   %改变运动方向
for k=1:1:n/p
    for i=1:1:p
        t(i+1)=t(i)+h;
        y(i+1,:)=trapstep(t,y(i,:),h);
    end
    y(1,:)=y(p,:);
    t(1)=t(p);
    set(sun,'xdata',sunx,'ydata',suny);
    set(head,'xdata',y(1,1),'ydata',y(1,3));
    set(tail,'xdata',y(2:p,1),'ydata',y(2:p,3));
    drawnow;
    pause(h);
end

    function y=trapstep(t,x,h)
        z1=ydot(t,x);
        g=x+h*z1;
        z2=ydot(t+h,g);
        y=x+h*(z1+z2)/2;
    end

    function z=ydot(t,x)
        m2=3;g=1;mg2=m2*g;
        dis=(sqrt(x(1)*x(1)+x(3)*x(3)))^3;
        z=zeros(1,4);
        z(1)=x(2);
        z(2)=-mg2*x(1)/(dis);
        z(3)=x(4);
        z(4)=-mg2*x(3)/(dis);
    end
end