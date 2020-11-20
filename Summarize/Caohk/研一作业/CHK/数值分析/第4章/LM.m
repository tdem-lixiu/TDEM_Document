clc;
clear;
n=100;   %设置最大迭代次数
x0=[1;1];  %赋初始值
x=x0;
lamb=100;  %lamb为正则化参数,初始取得足够大
v=zeros(length(x),1);
for k=1:n
    A=zeros(0,0);
    y=fun(x);
    for i=1:length(x)  %用差商代替微商，求解雅可比矩阵
        x1=x;
        x1(i)=x1(i)*1.01;
        A=[A (fun(x1)-y)*100/x1(i)];
    end
    invA=A.'*A;  %求AT*A
    invA=invA+lamb*diag(invA);  %改进系数矩阵的条件数
    b=-A.'*y;
    v=invA\b;
    x0=x+v;
    
    j=1;
    while 1
        if abs( sum(fun(x0)) ) < abs( sum(y) ) || j>10
            break;
        end
        lamb=lamb/2;
        x0=x+v;
        j=j+1;
    end
    x=x0;
    
    if all( abs(v) <= 0.01 )
        disp('满足收敛条件');
        v
        break
    end
end
disp('最终迭代结果残差为：');
fun(x)
disp('最终迭代结果x为：');
disp(x);


function R_residual=fun(x)  %最小二乘的目标函数
x1=[-1;1;1];
y1=[0;0.5;-0.5];
R1=[1;0.5;0.5];
R_residual=abs( sqrt( ( x(1)-x1 ).^2+( x(2)-y1 ).^2 ) - R1 );
end
