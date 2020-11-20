% ����6.5 ��������Ļ�ͼ����
% ���룺ʱ������ a,b����ʼ����
% ic1=[x10 vx10 y10 vy10]��x1��λ�ã�x1�ٶȣ�y1��λ�ã�y1�ٶȣ�����1��
% ic2=[x20 vx20 y20 vy20]��x2��λ�ã�x2�ٶȣ�y2��λ�ã�y2�ٶȣ�����2��
% ����n��ÿ��������p�Ĳ�����
% ���õ������������� trapstep.m
% ʹ��ʾ���� orbit2(0,100,[2 0.2 2 -0.2],[0 -0.01 0 0.01]��10000,10)
function z=oribt2(a,b,ic1,ic2,n,p)
h=(b-a)/n;
t(1)=a;
y1(1,:)=ic1;
y2(1,:)=ic2;
m1=0.3;m2=0.03;
set(gca,'xlim',[-5,20],'ylim',[-20,5], ...
        'xtick',(-5:20),'ytick',[-20:5], ...
        'Nextplot','add','Visible','on','Drawmode','fast');
cla;
axis square;
sun=line('color','r','Marker','.','markersize',25,...
         'erase','xor','xdata',[],'ydata',[]);   %����2
head=line('color','g','Marker','.','markersize',25, ...
          'erase','xor','xdata',[],'ydata',[]);  %����1
tail1=line('color','b','LineStyle','-','erase','none', ...
          'xdata',[],'ydata',[]);                %����1���˶��켣
tail2=line('color','b','LineStyle','-','erase','none', ...
          'xdata',[],'ydata',[]);                %����2���˶��켣
% [px,py]=ginput(1);
% [px1,py1]=ginput(1);
% y(1,:)=[px px1-px py py1-py];   %�ı��˶�����
for k=1:1:n/p
    for i=1:1:p
        t(i+1)=t(i)+h;
        y1(i+1,:)=trapstep(t(i),y1(i,:),h,m2,y2(i,:));
        y2(i+1,:)=trapstep(t(i),y2(i,:),h,m1,y1(i,:));
    end
    y1(1,:)=y1(p+1,:);
    y2(1,:)=y2(p+1,:);
    t(1)=t(p);
    set(sun,'xdata',y2(1,1),'ydata',y2(1,3));
    set(head,'xdata',y1(1,1),'ydata',y1(1,3));
    set(tail1,'xdata',y1(2:p,1),'ydata',y1(2:p,3));
    set(tail2,'xdata',y2(2:p,1),'ydata',y2(2:p,3));
    drawnow;
    pause(h);  %pause(h)���Ե��ⲥ�ŵ�����
end
    function y=trapstep(t,x,h,m,x2)
        z1=ydot(t,x,m,x2);
        g=x+h*z1;
        z2=ydot(t+h,g,m,x2);
        y=x+h*(z1+z2)/2;
    end

    function z=ydot(t,x1,m,x2)
        g=1;mg=m*g;
        xd=x2(1)-x1(1);
        yd=x2(3)-x1(3);
        dis=(sqrt(xd*xd+yd*yd))^3;
        z=zeros(1,4);
        z(1)=x1(2);
        z(2)=mg*xd/(dis);
        z(3)=x1(4);
        z(4)=mg*yd/(dis);
    end
end