% 此程序是关于欧拉算法的时频转换
% 参考文献：《Two effective inverse Laplace transform algorithms for 
%             computing time-domain electromagnetic responses 》、
%           《逆 Laplace 变换新算法及其在时间域电磁响应计算中的应用》
function nvalue=tft_euler(r,a,I0,h,z,n,econ,H,t,miu0,M)
nt=length(t);
nvalue(1:nt)=0;
% 常数设置M，2*M+1是欧拉变换的节点数
% M=7;
% 常数设置
Bm=M*log(10)/3+1i*pi*( (1:(2*M+1))-1 );
Qm(1)=0.5;
Qm(2:M+1)=1;
Qm(2*M+1)=2^(-M);
for i=1:1:M-1
    Qm(2*M+1-i)=Qm(2*M+2-i)+2^(-M)*factorial(M)/(factorial(i)*factorial(M-i));
end
Cm=(-1).^(( 1:(2*M+1) )-1) .* Qm;

for k=1:1:nt     
    w=-Bm/t(k)*1i;
    % 计算每个时间点的频率域响应
    hz_f=hankel_Gups(w,r,a,I0,h,z,n,econ,H,miu0);
    nvalue(k)=nvalue(k)+Cm*real(hz_f);
    nvalue(k)=10^(M/3)*nvalue(k)/t(k);
end
end