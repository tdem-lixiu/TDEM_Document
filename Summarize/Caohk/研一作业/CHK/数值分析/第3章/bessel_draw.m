function bessel_draw(x,y)
n=length(x);
k=floor(n/4);
ny=length(y);
ky=floor(ny/4);
if (n/4-k)>eps || (ny/4-ky)>eps
   error('the x or y is not satisfy requirement'); 
end
t=0:0.01:1;
for i=1:1:k
    x4=x(4*(i-1)+1:4*i);
    y4=y(4*(i-1)+1:4*i);
    [dx4,dy4]=bessel_curve(x4,y4,t);
    plot([x4(1) x4(2)],[y4(1) y4(2)],'b:o');
    plot([x4(3) x4(4)],[y4(3) y4(4)],'b:o');
    plot(dx4,dy4);
    grid on;
    hold on;
end
end
