% ���㷨Ϊ����4�еĲ�ֽ����㷨
%%
% ����ֵ
clc;
clear;
close all;
warning off;
NP=100;   %Ⱥ���С
n=2;    %���������
F0=0.5;   %��������
s1_a=1.0;  %�����г�������֪;
s5_a=8;
s5_b=200;
n_iter=500;   %��������
error_y=1.d-5;   %�������ֵ
number=0;     %������
% ����̵�Ԥ��s2,s3ΪԤ�����۶�,s4Ϊ�����ʣ�s5Ϊ�̼Ҹ���,s1Ϊ�׼�
s2=20.85;
s3=27.94;
s4=2.075;
Ps=0.51;   %�ж���ֵ
s1_b=(0.025*s2+0.002*s3+0.007*s4+0.496-Ps)/0.027;  %�������׼�

% ��ʼ��ȡֵ
%%
global net minp maxp mint maxt;
load a_net.mat net minp maxp mint maxt;  %��ȡ������
x(1,:)=rand(1,NP)*(s1_b-s1_a)+s1_a;   %�����ʼ����ÿһ�д���һ�����壬����=������������=������
x(2,:)=rand(1,NP)*(s5_b-s5_a)+s5_a;
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
    if u(1,j)>s1_b
        u(1,j)=s1_b;
    elseif u(1,j)<s1_a
        u(1,j)=s1_a;
    end
    if u(2,j)>s5_b
        u(2,j)=s5_b;
    elseif u(2,j)<s5_a
        u(2,j)=s5_a;
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
    temp(2)=ymin(n_best);
    n_best=n_best+1;
    mseq(n_best)=i;
    ymin(n_best)=temp(1);                 %��¼��ʷ����ֵ 
    y_x(:,n_best)=x(:,y_pos(1));         %��¼��ʷ���Ž�
end

%  ������Ӧ�ȣ����������ֵ end
if abs(temp(1)-temp(2))<=error_y   
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
plot(mseq(1:end),50-ymin(1:end))
xlabel('��������');
ylabel('�������f(x)');
title('��ֽ����㷨');
str=strcat('��Сֵ��',num2str(ymin(n_best)));
sk=strcat('��Сֵ���ڵ�',num2str(mseq(end)-1),'�ε���');
text(1,3,sk,'FontSize',12);
text(1,1,str,'FontSize',12);
disp('��������ǣ�')
disp(50-ymin(n_best))
disp('���ŵ׼ۡ�����������������')
disp(y_x(1,n_best).')
disp((y_x(2,n_best)-8).^2*0.001);
y_x(2,n_best)
disp('��Сֵ�ĵ���������');
disp(mseq(end)-1)
%%
% Ŀ�꺯��
function result=fun(x)
% ����̵�Ԥ��s2,s3ΪԤ�����۶�,s4Ϊ�����ʣ�s5Ϊ�̼Ҹ���,s1Ϊ�׼�
global net minp maxp mint maxt;
[~,n]=size(x);
Ax=zeros(1,n);
for i=1:1:n
mx=tramnmx(x(1,i),minp,maxp);
Bx=sim(net,mx);
Ax(i)=postmnmx(Bx,mint,maxt);
end
result=( Ax.*(1+x(2,:)/500) )  -( x(2,:)-8 ).^2*0.001;
result = 50-result;
end