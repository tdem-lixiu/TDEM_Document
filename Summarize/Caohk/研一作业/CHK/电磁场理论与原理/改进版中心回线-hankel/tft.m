% k_cs�������ҵ��˲�ϵ����w��Ƶ�ʣ�t��ʱ�䣬exp(t1)��exp(t2)�Ǽ����������ʱ��
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