% ����6.4 �Ӱڶ�������
% ���룺ʱ������a,b
%       ��ʼֵic=[y(1,1) y(1,2)],����n
% ���õ������������� trapstep.m
% ʹ��ʽ����pend(0,10,[pi/2 0],200)
function pend(a,b,ic,n)
t(1)=a;
y(1,:)=ic;
h=(b-a)/n;
set(gca,'xlim',[-1.2 1.2],'ylim',[-1.2 1.2], ...
        'xtick',[-1 0 1],'YTick',[-1 0 1], ...
        'Drawmode','fast','Visible','on','NextPlot','add');
cla;
axis square;
bob=line('color','r','Marker','.','markersize',40,...
   'erase','xor', 'xdata',[],'ydata',[]);
rod=line('color','b','LineStyle','-','LineWidth',3,...
    'erase','xor','xdata',[],'ydata',[]);
for k=1:n
    t(k+1)=t(k)+h;
    y(k+1,:)=trapstep(t(k),y(k,:),h);
    xbob=sin(y(k+1,1));ybob=-cos(y(k+1,1));
    xrod=[0 xbob];yrod=[0 ybob];
    set(rod,'xdata',xrod,'ydata',yrod);
    set(bob,'xdata',xbob,'ydata',ybob);
    drawnow;pause(h);
end

    function y=trapstep(t,x,h)
        z1=ydot(t,x);
        g=x+h*z1;
        z2=ydot(t+h,g);
        y=x+h*(z1+z2)/2; 
    end

% d��������������Ħ�������µ�˥��ϵ������������У���ϵ��Ϊ0
% A���������ϵ��
    function z=ydot(t,y)
        g=9.81;length=1;d=1;  
        A=15;
        z(1)=y(2);
        z(2)=-(g/length)*sin(y(1))-d*y(2)+A*sin(t);
    end
end