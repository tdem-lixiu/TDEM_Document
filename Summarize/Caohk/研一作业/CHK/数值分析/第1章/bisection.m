% �˳����������ڶ��ַ�Ѱ��ֵ---chk
% ���룺a�������ޣ�
%       b�������ޣ�
% �����c������ַ�ȷ����xֵ
% function c=bisection(f,a,b)
%  while abs(b-a)>1.e-2
%      c=(b+a)/2;
%      if abs(f(c))<1.e-2
%          break
%      else if sign(f(a))*sign(f(c))<0
%              b=c;
%          else
%              a=c;
%      end 
%      end
%  end
% end

% ������ַ�
% ����f(x)=0�Ľ���ֵ
% ���룺�������f��a��b���������ޣ���Ҫʹf(a)*f(b)<0������
%       �Լ��ݲ�total
% �����ʹf=0�Ľ���ֵc,kʹ�ڲ���������������������
function c=bisection(f,a,b,total)
if nargin==3
    total=1.e-10;
end 
if nargin<3
     error('that input do not meet requirement') %ֹͣ����
 end 
if sign(f(a))*sign(f(b))>=0
    error('f(a)f(b)<0 not satisfied') %ֹͣ����
end 
fa=f(a);
fb=f(b);
k=0;
while (abs(b-a))>total
    k=k+1;
    c=(a+b)/2;
    fc=f(c);
    if abs(fc)<2.22e-22
        break
    end
    if sign(fa)*sign(fc)<0
        fb=fc;
        b=c;
    else 
        fa=fc;
        a=c;
    end
    c=(a+b)/2;
end
k
end

    