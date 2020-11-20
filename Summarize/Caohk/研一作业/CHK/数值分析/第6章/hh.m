% 程序6.5 Hodgkin-Huxley方程
% 输入：时间区间 inter,
% ic=初始电压v和3门限变量，步数n
% 输出： 解 y；
% 调用单步方法诸如rk4step.m
% 使用示例：hh([0,100],[-65,0,0.3,0.6],2000)；
% 有问题待解决
function y=hh(inter,ic,n)
global pa pb pulse
inp=input('pilse start,end,muamps in [],e.g. [50 51 7]:');
pa=inp(1);pb=inp(2);pulse=inp(3);
a=inter(1);b=inter(2);hh=(b-a)/n;  %画出几个点
y(1,:)=ic;
t(1)=a;
for i=1:1:n
    t(i+1)=t(i)+1;
    y(i+1,:)=rk4step(t(i),y(i,:),hh);
end
subplot(3,1,1);
plot([a pa pa pb pb b],[0 0 pulse pulse 0 0]);
grid;axis([0 100 0 2*pulse])
ylabel('input pulse');

subplot(3,1,2);
plot(t,y(:,1));grid;axis([0 100 -100 100]);
ylabel('voltage (mV)');

subplot(3,1,3);
plot(t,y(:,2),t,y(:,3),t,y(:,4));
grid;axis([0 100 0 1]);
ylabel('gating variables');
legend('m','n','h');
xlabel('time (msec)');

function y=rk4step(t,w,h)
s1=ydot(t,w);
s2=ydot(t+h/2,w+h*s1/2);
s3=ydot(t+h/2,w+h*s2/2);
s4=ydot(t+h,w+h*s3);
y=w+h*(s1+2*s2+2*s3+s4)/6;
end

    function z=ydot(t,w)
%         global pa pb pulse
        
        c=1;g1=120;g2=36;g3=0.3;T=(pa+pb)/2;len=pb-pa;
        e0=-65;e1=50;e2=-77;e3=-54.4;
        in=pulse*(1-sign(abs(t-T)-len/2))/2;
        % 在区间[pa,pb]对于脉冲muamps的平方脉冲输入
        v=w(1);m=w(2);nn=w(3);hn=w(4);
        z=zeros(1,4);
        z(1)=(in-g1*m*m*m*hn*(v-e1)-g2*nn*nn*nn*nn*(v-e2)-g3*(v-e3))/c;
        v=v-e0;
        z(2)=(1-m)*(2.5-0.1*v)/(exp(2.5-0.1*v)-1)-m*4*exp(-v/18);
        z(3)=(1-nn)*(0.1-0.01*v)/(exp(1-0.1*v)-1)-nn*0.125*exp(-v/80);
        z(4)=(1-hn)*0.07*exp(-v/20)-hn/(exp(3-0.1*v)+1);
    end
end