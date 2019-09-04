% �˳����ǹ���ŷ���㷨��ʱƵת��
% �ο����ף���Two effective inverse Laplace transform algorithms for 
%             computing time-domain electromagnetic responses ����
%           ���� Laplace �任���㷨������ʱ��������Ӧ�����е�Ӧ�á�
function nvalue=tft_euler(r,a,I0,h,z,n,econ,H,t,miu0,M)
nt=length(t);
nvalue(1:nt)=0;
% ��������M��2*M+1��ŷ���任�Ľڵ���
% M=7;
% ��������
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
    % ����ÿ��ʱ����Ƶ������Ӧ
    hz_f=hankel_Gups(w,r,a,I0,h,z,n,econ,H,miu0);
    nvalue(k)=nvalue(k)+Cm*real(hz_f);
    nvalue(k)=10^(M/3)*nvalue(k)/t(k);
end
end