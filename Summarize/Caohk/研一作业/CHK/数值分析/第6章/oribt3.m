% 程序6.5 三体问题的画图程序；
% 输入：时间区间 a,b，初始条件
% ic1=[x10 vx10 y10 vy10]，x1的位置，x1速度，y1的位置，y1速度，物体1；
% ic2=[x20 vx20 y20 vy20]，x2的位置，x2速度，y2的位置，y2速度，物体2；
% ic3=[x30 vx30 y30 vy30]，x3的位置，x3速度，y3的位置，y3速度，物体3；
% 步数n，每个画出点p的步数；
% 调用单步方法，诸如 trapstep.m
% 使用示例： orbit3(0,100,[2 0.2 2 -0.2],[0 0 0 0],[-2,-0.2,-2,0.2],10000,10)
function z=oribt3(a,b,ic1,ic2,ic3,n,p)
h=(b-a)/n;
t(1)=a;
y1(1,:)=ic1;
y2(1,:)=ic2;
y3(1,:)=ic3;
m1=1;m2=1;m3=1;
set(gca,'xlim',[-5,5],'ylim',[-5,5], ...
        'xtick',[-5:5],'ytick',[-5:5], ...
        'Nextplot','add','Visible','on','Drawmode','fast');
cla;
axis square;
head1=line('color','r','Marker','.','markersize',25,...
         'erase','xor','xdata',[],'ydata',[]);   %物体1
head2=line('color','g','Marker','.','markersize',25, ...
          'erase','xor','xdata',[],'ydata',[]);  %物体2
head3=line('color','y','Marker','.','markersize',25, ...
          'erase','xor','xdata',[],'ydata',[]);  %物体3      
tail1=line('color','b','LineStyle','-','erase','none', ...
          'xdata',[],'ydata',[]);                %物体1的运动轨迹
tail2=line('color','b','LineStyle','-','erase','none', ...
          'xdata',[],'ydata',[]);                %物体2的运动轨迹 
tail3=line('color','b','LineStyle','-','erase','none', ...
          'xdata',[],'ydata',[]);                %物体3的运动轨迹
% [px,py]=ginput(1);
% [px1,py1]=ginput(1);
% y(1,:)=[px px1-px py py1-py];   %改变运动方向
for k=1:1:n/p
    for i=1:1:p
        t(i+1)=t(i)+h;
        y1(i+1,:)=trapstep(t(i),y1(i,:),h,m2,m3,y2(i,:),y3(i,:));
        y2(i+1,:)=trapstep(t(i),y2(i,:),h,m3,m1,y3(i,:),y1(i,:));
        y3(i+1,:)=trapstep(t(i),y3(i,:),h,m1,m2,y1(i,:),y2(i,:));
    end
    y1(1,:)=y1(p+1,:);
    y2(1,:)=y2(p+1,:);
    y3(1,:)=y3(p+1,:);
    t(1)=t(p);
    set(head1,'xdata',y1(1,1),'ydata',y1(1,3));
    set(head2,'xdata',y2(1,1),'ydata',y2(1,3));
    set(head3,'xdata',y3(1,1),'ydata',y3(1,3));
    set(tail1,'xdata',y1(2:p,1),'ydata',y1(2:p,3));
    set(tail2,'xdata',y2(2:p,1),'ydata',y2(2:p,3));
    set(tail3,'xdata',y3(2:p,1),'ydata',y3(2:p,3));
    drawnow;
    pause(h);  %pause(h)可以调解播放的速率
end
    function y=trapstep(t,x1,h,m2,m3,x2,x3)
        z1=ydot(t,x1,m2,m3,x2,x3);
        g=x1+h*z1;
        z2=ydot(t+h,g,m2,m3,x2,x3);
        y=x1+h*(z1+z2)/2;
    end

    function z=ydot(t,x1,m2,m3,x2,x3)
        g=1;mg2=m2*g;mg3=m3*g;
%         计算每两颗行星的位移差
        xd2=x2(1)-x1(1);
        yd2=x2(3)-x1(3);
        xd3=x3(1)-x1(1);
        yd3=x3(3)-x1(3);
%         计算两个行星之间的距离r
        dis2=(sqrt(xd2*xd2+yd2*yd2))^3;
        dis3=(sqrt(xd3*xd3+yd3*yd3))^3;
%         计算导数
        z=zeros(1,4);
        z(1)=x1(2);
        z(2)=mg2*xd2/(dis2)+mg3*xd3/(dis3);
        z(3)=x1(4);
        z(4)=mg2*yd2/(dis2)+mg3*yd3/(dis3);
    end
end