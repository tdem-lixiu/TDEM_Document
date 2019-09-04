% k_cs�������ҵ��˲�ϵ����w��Ƶ�ʣ�t��ʱ�䣬exp(t1)��exp(t2)�Ǽ����������ʱ��
function nvalue=tft_qwe(n_gauss,n_qmax,nu,t,n,econ,H,miu0,I0,a,r,z,h,relTol,absTol)
nt=length(t);
nvalue(1:nt)=0;
cs_sin=constant_sin;
nucull=-149;delt=log(10)/20;
for k=1:1:nt   
    w=exp(((1:1:250)-1+nucull)*delt)/t(k);
    hz_f=f_qwe(n_gauss,n_qmax,nu,w,n,econ,H,miu0,I0,a,r,z,h,relTol,absTol);
    nvalue(k)=imag(hz_f)*cs_sin';
    nvalue(k)=nvalue(k)*sqrt(pi/2.e0)/t(k)*2.e0/pi;
end
end