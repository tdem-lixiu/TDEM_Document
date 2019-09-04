% k_cs是正余弦的滤波系数；w是频率，t是时间，exp(t1)，exp(t2)是计算的上下限时间
function nvalue=tft(a,I0,n,econ,H,t,miu0)
nt=length(t);
nvalue(1:nt)=0;
cs_sin=constant_sin;
nucull=-149;delt=log(10)/20;
for k=1:1:nt 
        w=exp(((1:250)-1+nucull)*delt)/t(k);
        hz_f=hankel_Gups(w,a,I0,n,econ,H,miu0);
        nvalue(k)=nvalue(k)+cs_sin*imag(hz_f);
        nvalue(k)=-nvalue(k)*sqrt(pi/2.e0)/t(k)*2.e0/pi;
end
end