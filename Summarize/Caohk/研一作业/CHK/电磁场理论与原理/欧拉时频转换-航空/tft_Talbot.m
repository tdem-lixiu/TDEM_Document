% 此程序是关于Talbot算法的时频转换
% 参考文献：《Two effective inverse Laplace transform algorithms for 
%             computing time-domain electromagnetic responses 》、
%           《逆 Laplace 变换新算法及其在时间域电磁响应计算中的应用》
function nvalue=tft_Talbot(r,a,I0,h,z,n,econ,H,t,miu0,M)
nt=length(t);
nvalue(1:nt)=0;
% 常数设置M，M是Talbo变换的节点数
% 常数设置
km=(1:(M-1))*pi/M;
ckm=cot(km);
Qm(1)=0.4*M;
Qm(2:M)=0.4*( 1:(M-1) )*pi.*(ckm+1i);
Cm(1)=0.5*exp( Qm(1) );
Cm(2:M)=( 1+1i.*km.*(1+ckm.*ckm)-1i.*ckm ).*exp(Qm(2:M));

for k=1:1:nt     
    w=-Qm/t(k)*1i;
    % 计算每个时间点的频率域响应
    hz_f=hankel_Gups(w,r,a,I0,h,z,n,econ,H,miu0);
    nvalue(k)=real(Cm*hz_f)/t(k)*0.4;
end
end