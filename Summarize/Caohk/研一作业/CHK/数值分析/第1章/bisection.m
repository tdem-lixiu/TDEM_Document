% 此程序是运用于二分法寻找值---chk
% 输入：a代表下限，
%       b代表上限，
% 输出：c代表二分法确定的x值
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

% 程序二分法
% 计算f(x)=0的近似值
% 输入：函数句柄f；a，b代表下上限；且要使f(a)*f(b)<0成立，
%       以及容差total
% 输出：使f=0的近似值c,k使内部输入参数，代表迭代次数
function c=bisection(f,a,b,total)
if nargin==3
    total=1.e-10;
end 
if nargin<3
     error('that input do not meet requirement') %停止运行
 end 
if sign(f(a))*sign(f(b))>=0
    error('f(a)f(b)<0 not satisfied') %停止运行
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

    