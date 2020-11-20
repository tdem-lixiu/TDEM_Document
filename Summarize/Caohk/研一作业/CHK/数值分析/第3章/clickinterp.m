% 程序3.2 多项式插值程序；作者：曹华科；时间：2018年9月29日；
% 点击matlab图像窗口定位数据点
% 继续，加入更多的点
% 按return键结束程序
function clickinterp
xl=-3;xr=3;yb=-3;yt=3;
plot([xl xr],[0 0],'k',[0 0],[yb yt],'k');grid on;
xlist=[];ylist=[];
k=0;
while(0==0)
    [xnew,ynew]=ginput(1);
    if length(xnew)<1
        break;
    end
    k=k+1;
    xlist(k)=xnew;ylist(k)=ynew;
    c=newtdd(xlist,ylist);
    x=xl:0.01:xr;
    y=nest(k-1,c,x,xlist);
    plot(xlist,ylist,'o',x,y,[xl xr],[0,0],'k',[0 0],[yb yt],'k');
    axis([xl xr yb yt]);grid on
end
end