function K=Inside3(I,I_cond,k,source,I_point,I_xy,I_left,I_right,I_bottom)
K=zeros(4,4,I);
xy_source=I_xy(:,I_point(1,source));
xy_left=I_xy(:,I_point(1,I_left));
xy_right=I_xy(:,I_point(1,I_right));
xy_bottom=I_xy(:,I_point(1,I_bottom));
n_left=length(I_left);
n_right=length(I_right);
n_bottom=length(I_bottom);
% 左边界处理 start
for i=1:1:n_left
    I=I_left(i);
    r=sqrt( (xy_left(1,i)-xy_source(1))^2+(xy_left(2,i)-xy_source(2))^2 );   %求取点距
    cosa=abs(xy_left(1,i)-xy_source(1))/r;          %求取夹角cos
    b=I_xy(2,I_point(1,I))-I_xy(2,I_point(2,I));
    beta=b*I_cond(I)*k*bessely(1,k*r)*cosa/6/bessely(0,k*r);  %bessely第二类bessel函数
    K(1,1,I)=2*beta;
    K(2,1,I)=beta;
    K(2,2,I)=K(1,1,I);
end
% 左边界处理 end

% 右边界处理 start
for i=1:1:n_right
    I=I_right(i);
    r=sqrt( (xy_right(1,i)-xy_source(1))^2+(xy_right(2,i)-xy_source(2))^2 );   %求取点距
    cosa=abs(xy_right(1,i)-xy_source(1))/r;          %求取夹角cos
    b=I_xy(2,I_point(1,I))-I_xy(2,I_point(2,I));
    beta=b*I_cond(I)*k*bessely(1,k*r)*cosa/6/bessely(0,k*r);  %bessely第二类bessel函数
    K(1,1,I)=2*beta;
    K(2,1,I)=beta;
    K(2,2,I)=K(1,1,I);
end
% 右边界处理 end

% 底边界处理 start
for i=1:1:n_bottom
    I=I_bottom(i);
    r=sqrt( (xy_bottom(1,i)-xy_source(1))^2+(xy_bottom(2,i)-xy_source(2))^2 );   %求取点距
    sina=abs(xy_bottom(2,i)-xy_source(2))/r;          %求取夹角cos
    a=I_xy(1,I_point(4,I))-I_xy(1,I_point(1,I));
    beta=a*I_cond(I)*k*bessely(1,k*r)*sina/6/bessely(0,k*r);  %bessely第二类bessel函数
    K(1,1,I)=2*beta;
    K(2,1,I)=beta;
    K(2,2,I)=K(1,1,I);
end
% 底边界处理 end


for i=1:1:I
    K(:,:,i)=K(:,:,i)+triu(K(:,:,i).',1); %构建对称矩阵  
end
end