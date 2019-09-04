% 生成频率采样程序
% 输入：a，b是频率的下上限，
%       n是生成的采样个数；
% 输出：t是时间采样数组
function t=tsamp(a,b,n)
%生成对数坐标系下的等间距采样
delt=(log10(b)-log10(a))/(n-1);
t=zeros(1,n);
for i=1:1:n
    t(i)=10^(log10(a)+delt*(i-1));
end
end