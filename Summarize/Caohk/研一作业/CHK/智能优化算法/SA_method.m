% ���ڣ�2019/03/02�����ߣ��ܻ��ƣ����������Ż��㷨-ģ���˻�-δ�Ż�
clc;
clear;
% Intelligent optimization algorithm �����Ż��㷨-ģ���˻�-����
% ��ʼ�� start
t0=100;   %��ʼ�¶�  %90
tn=0.01;      %��ȴ�¶�
atten=0.999; %�¶�˥��ϵ��
n_t=5;      %���ٴβ���ʱ�˳���ѭ��
n_L=5;      %���ٴβ���ʱ�˳���ѭ��
L=500;      %�ڲ����ѭ������
step=0.2;   %�������Ĳ��� 0.2
yz=1.d-3;   %�������ֵ
x_a=-1.28;  %x������
x_b=1.28;   %x������
n_x=20;     %x��ֵ�Ĵ�С
x0=rand(n_x,1)*(x_b-x_a)+x_a; %�����ʼ��x
% ��ʼ�� end

%% ���㲽��
x=x0;
t=t0;
flag1=0;   % ��ѭ����־
flag2=0;   % ��ѭ����־
y(1)=fun(x); % ��ѭ��������ֵ
k=1;
f(1)=y(1);  % ��ѭ��������ֵ
kk=1;
tic;
while 1 
    if t<tn   %����������¶ȣ��˳�ѭ��
       break;
    end
    %------------------------- ��ѭ�� start -------------------------%
    for i=1:1:L    
        x_k=x+step*(rand(n_x,1)*(x_b-x_a)+x_a); % ����Metropolis����
        
        %�Գ������޵�ֵ���д��� start
        for j=1:1:n_x
            if x_k(j)<x_a
                x_k(j)=x_a;
            elseif x(j)>x_b
                x_k(j)=x_b;
            end
        end
        %�Գ������޵�ֵ���д��� end
        
        % ���¹��� start
        y_m=fun(x_k);
        if y_m < y(k)
            k=k+1;
            y(k)=y_m;
            x=x_k;
            x_best=x;
        elseif exp( -(y_m-y(k))/t ) >=  rand
            x=x_k;
        end
        % ���¹��� end
        
        % �ж����Ž��Ƿ�ﵽ�ȶ�
        if k<=1
            
        elseif abs(y(k)-y(k-1)) <yz
            flag1=flag1+1;
        else
            flag1=0;
        end
        if flag1 >= 5
            break;
        end
    end
    %-------------------------- ��ѭ�� end --------------------------%
    
    t=t*atten; %�¶���ȴ,���¹���
    if y(k) < f(kk)
        kk=kk+1;
        f(kk)=y(k);
    end
    if kk<=1
        
    elseif abs(f(kk)-f(kk-1))<yz
        flag2=flag2+1;
    else
        flag2=0;
    end
    
    if flag2>=5
        break;
    end
    
end
toc;


%% ��ͼ�Լ��������
t
if t<=0.01
    disp('δ�ﵽ����Ҫ��');
else
    disp('������¶�֮ǰ�ﵽ����Ҫ��');
end
plot(y(2:end))
xlabel('��������');
ylabel('����ֵf(x)');
title('ģ���˻�');
str=strcat('��Сֵ��',num2str(y(k)));
sk=strcat('��Сֵ���ڵ�',num2str(k-1),'�ε���');
text(0,10,sk,'FontSize',12);
text(0,4,str,'FontSize',12);
disp('��Сֵ�ǣ�')
y(k)
disp('���Ž��ǣ�')
x_best.'
disp('��Сֵ�ĵ���������');
k-1

%%
% Ŀ�꺯��
function result=fun(x)
n=length(x);
result=(1:n)*(x.^4)+rand;
end

