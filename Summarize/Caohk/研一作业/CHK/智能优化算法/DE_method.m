clc;
clear;
NP=100;   %Ⱥ���С
n=20;    %���������
F0=0.5;   %��������
x_a=-1.28;  %x������
x_b=1.28;   %x������
n_iter=500;   %��������
error_y=1.d-3;   %�������ֵ
number=0;     %������
x=rand(n,NP)*(x_b-x_a)+x_a;   %�����ʼ����ÿһ�д���һ�����壬����=������������=������
v=rand(n,NP);
u=rand(n,NP);
u=x;
y1=fun(x); 
[temp,y_pos]=sort(y1);            %��¼������ʷλ��
ymin(1)=temp(1);                  %��¼��ʷ����ֵ          
y_x=x(:,y_pos(1));
n_best=1;    %��n������ֵ
mseq(1)=0;
%%
for i=1:1:n_iter


% ������� start
  for k=1:1:NP
      % ѡ��������ͬ�ĸ��壬���в�� start
      r=randperm(NP,4);
      r1=r(1);
      r2=r(2);
      r3=r(3);
      if r1==k
          r1=r(4);
      elseif r2==k
          r2=r(4);
      elseif r3==k
          r3=r(4);
      end
       % ѡ��������ͬ�ĸ��壬���в�� end
       % ��������Ӧ���� start
       lamb=exp(1-n_iter/(n_iter-i+1));
       F=F0*2^(lamb);
       % ��������Ӧ���� end
       v(:,k)=x(:,r(1))+F*( x(:,r(2)) - x(:,r(3)) );
  end      
% ������� end

%  ���н������ start
CR=0.5*(1+rand);
Ln=randi([1,n]);
for k=1:1:n
    if rand <= CR || k==Ln
        u(k,:)=v(k,:);
    else
        u(k,:)=x(k,:);
    end
end
%  ���н������ end


% ���б߽紦�� start
for j=1:1:NP
    for k=1:1:n
        if u(k,j)>x_b
            u(k,j)=x_b;
        elseif u(k,j)<x_a
            u(k,j)=x_a;
        end
    end
end
% ���б߽紦�� end



%     ����ѡ�����  start
    y=fun(u);
    for k=1:1:NP
        if y(k) < y1(k)
            x(:,k) = u(:,k);
        end
    end
%     ����ѡ�����  end 
%     x�Ǿ���ѡ���Ƶ���Ⱥ��,u���ϴε����еľ�Ⱥ��

%  ������Ӧ�ȣ����������ֵ start
y1=fun(x);            
[temp,y_pos]=sort(y1);                   %��¼������ʷλ��
if(temp(1)<ymin(n_best))
    n_best=n_best+1;
    mseq(n_best)=i;
    ymin(n_best)=temp(1);                 %��¼��ʷ����ֵ 
    y_x(:,n_best)=x(:,y_pos(1));         %��¼��ʷ���Ž�
end

%  ������Ӧ�ȣ����������ֵ end
if abs(temp(1)-ymin(n_best))<=error_y   
    number=number+1;
    if number>=5
        break;
    end
else
    number=0;
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
title('��ֽ����㷨');
str=strcat('��Сֵ��',num2str(ymin(n_best)));
sk=strcat('��Сֵ���ڵ�',num2str(mseq(end)-1),'�ε���');
text(1,3,sk,'FontSize',12);
text(1,1,str,'FontSize',12);
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