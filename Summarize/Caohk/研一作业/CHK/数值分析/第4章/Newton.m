clc;
clear;
n=100;   %��������������
x0=[1;1];  %����ʼֵ
x=x0;
v=zeros(length(x),1);
for k=1:n
    A=zeros(0,0);
    y=fun(x);
    for i=1:length(x)  %�ò��̴���΢�̣�����ſɱȾ���
        x1=x;
        x1(i)=x1(i)*1.01;
        A=[A (fun(x1)-y)*100/x1(i)];
    end
    invA=A.'*A;  %��AT*A
    b=-A.'*y;
    v=invA\b;
    x=x+v;
    if all( abs(v) <= 0.01 )
        disp('������������');
        v
        break
    end
end
disp('���յ�������в�Ϊ��');
fun(x)
disp('���յ������xΪ��');
disp(x);


function R_residual=fun(x)  %��С���˵�Ŀ�꺯��
x1=[-1;1;1];
y1=[0;0.5;-0.5];
R1=[1;0.5;0.5];
R_residual=abs( sqrt( ( x(1)-x1 ).^2+( x(2)-y1 ).^2 ) - R1 );
end
