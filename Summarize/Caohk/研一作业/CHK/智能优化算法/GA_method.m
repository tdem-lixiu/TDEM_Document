clc;
clear;
L=200;   %Ⱥ���С
n=10;    %���������
Pc=0.8;  %�������
Pm=0.4;  %�������
x_a=-1.28;  %x������
x_b=1.28;   %x������
n_iter=300;   %��������
error_y=1.d-3;   %�������ֵ

x0=rand(n,L)*(x_b-x_a)+x_a;   %�����ʼ����ÿһ�д���һ�����壬����=������������=������
x=x0;
y1=fun(x0); 
[temp,y_pos]=sort(y1);            %��¼������ʷλ��
ymin(1)=temp(1);                  %��¼��ʷ����ֵ          
y_x=x0(:,y_pos(1));
n_best=1;    %��n������ֵ
mseq(1)=0;
%%
for i=1:1:n_iter
%     ����ѡ�����  start
    Pi=(temp(end)-y1)/(temp(end)-temp(1));      %����������Ӧ��
    Pi=Pi/(sum(Pi));
    Pi=cumsum(Pi);   %��������
    P=rand(1,L);  
    for j=1:1:L
        for k=1:1:L
            if rank(1,1) <= Pi(k)
                x(j)=x0(k);
            end
        end
    end
%     ����ѡ�����  end 
%     x�Ǿ���ѡ���Ƶ���Ⱥ��,x0���ϴε����еľ�Ⱥ��

%  ���н������ start
n_Pc=floor(Pc*L/2);
rand_Pc=randperm(L);   %�������˳������
for k=1:1:n_Pc
    rand_Pcpos=unidrnd(n-1); %���ѡȡȾɫ�彻��λ��
    x(1:rand_Pcpos,rand_Pc(k))=x(1:rand_Pcpos,rand_Pc(k+n_Pc));
    x(rand_Pcpos:end,rand_Pc(k+n_Pc))=x(rand_Pcpos:end,rand_Pc(k));
end
%  ���н������ end

%  ���б������ start
for j=1:1:L
    for k=1:1:n
        if rand >= Pm
            x(k,j)=rand*(x_b-x_a)+x_a;
        end
    end
end
%  ���б������ end

%  ������Ӧ�ȣ����������ֵ start

y1=fun(x);             
[temp,y_pos]=sort(y1);                   %��¼������ʷλ��
% x(:,y_pos(end))=x0(:,1);
x0=x;
if(temp(1)<ymin(n_best))
    n_best=n_best+1;
    mseq(n_best)=i;
    ymin(n_best)=temp(1);                 %��¼��ʷ����ֵ 
    y_x(:,n_best)=x0(:,y_pos(1));         %��¼��ʷ���Ž�
end

%  ������Ӧ�ȣ����������ֵ end
if ymin(n_best)<=error_y
    break;
end  

end
%%
% ��ͼ
i
if i>=n_iter
    disp('δ�ﵽ����Ҫ��');
else
    disp('�ﵽ����Ҫ���˳�ѭ��');
end
plot(mseq(1:end),ymin(1:end))
xlabel('��������');
ylabel('����ֵf(x)');
title('�Ŵ��㷨');
str=strcat('��Сֵ��',num2str(ymin(n_best)));
sk=strcat('��Сֵ���ڵ�',num2str(mseq(end)-1),'�ε���');
text(1,0.1,sk,'FontSize',12);
text(1,0.3,str,'FontSize',12);
disp('��Сֵ�ǣ�')
ymin(n_best)
disp('���Ž��ǣ�')
y_x(:,n_best).'
disp('��Сֵ�ĵ���������');
mseq(end)-1
%%
% Ŀ�꺯��
function result=fun(x)
[n1,~]=size(x);
x1=(1:n1);
result=x1*(x.^4)+rand(1,1);
end