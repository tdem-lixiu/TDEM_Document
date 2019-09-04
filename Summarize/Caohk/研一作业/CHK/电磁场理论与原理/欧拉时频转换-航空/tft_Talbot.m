% �˳����ǹ���Talbot�㷨��ʱƵת��
% �ο����ף���Two effective inverse Laplace transform algorithms for 
%             computing time-domain electromagnetic responses ����
%           ���� Laplace �任���㷨������ʱ��������Ӧ�����е�Ӧ�á�
function nvalue=tft_Talbot(r,a,I0,h,z,n,econ,H,t,miu0,M)
nt=length(t);
nvalue(1:nt)=0;
% ��������M��M��Talbo�任�Ľڵ���
% ��������
km=(1:(M-1))*pi/M;
ckm=cot(km);
Qm(1)=0.4*M;
Qm(2:M)=0.4*( 1:(M-1) )*pi.*(ckm+1i);
Cm(1)=0.5*exp( Qm(1) );
Cm(2:M)=( 1+1i.*km.*(1+ckm.*ckm)-1i.*ckm ).*exp(Qm(2:M));

for k=1:1:nt     
    w=-Qm/t(k)*1i;
    % ����ÿ��ʱ����Ƶ������Ӧ
    hz_f=hankel_Gups(w,r,a,I0,h,z,n,econ,H,miu0);
    nvalue(k)=real(Cm*hz_f)/t(k)*0.4;
end
end