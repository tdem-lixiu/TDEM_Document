% �����������ڲ���ŷ���㷨��
% ��ʽΪ��F(s)=1/s��ԭ�����ǣ�1
clc;
clear;
t=tsamp(1.d-8,1.d8,9);
nt=length(t);
nvalue(1:nt)=0;
%%
% ŷ���㷨
M=17;
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
    s=Bm/t(k);
    % ����ÿ��ʱ����Ƶ������Ӧ
    hz_f=1./s;   %1./(sqrt(s)+sqrt(s+1));
    hz_f=hz_f';
    nvalue(k)=Cm*real(hz_f);
    nvalue(k)=10^(M/3)*nvalue(k)/t(k);
end
nvalue

%%
% Talbot�㷨
clear;
t=tsamp(1.d-8,1.d8,9);
nt=length(t);
tM=21;
tnvalue(1:nt)=0;
% ��������
km=(1:(tM-1))*pi/tM;
ckm=cot(km);
tQm(1)=0.4*tM;
tQm(2:tM)=0.4*( 1:(tM-1) )*pi.*(ckm+1i);
tCm(1)=0.5*exp( tQm(1) );
tCm(2:tM)=( 1+1i*km.*(1+ckm.*ckm)-1i*ckm ).*exp(tQm(2:tM));
for k=1:1:nt     
    s=tQm/t(k);
    % ����ÿ��ʱ����Ƶ������Ӧ
    thz_f=1./s;
    tnvalue(k)=real(sum(tCm.*thz_f))/t(k)*0.4;
end
tnvalue

%%
% �����е�Talbot�㷨
clear;
M=21;
f_s=@(s) 1./s;
t=tsamp(1.d-8,1.d8,9);
k = 1:( M-1); % ����ָ�룬�ڵ��� M ȡ���������� 21��% ����ڵ�ֵ��delta = zeros( 1��M) ;
delta(1) = 2* M /5;
delta( 2:M)=2*pi/5*k.*(cot(pi/M* k)+1i) ;% ����Ȩϵ����gamma = zeros( 1��M) ;
gamma(1)=0.5* exp( delta(1) ) ;
gamma(2:M)=( 1+1i*pi/M*k.*( 1+cot(pi/M*k).^2)-1i*cot(pi/M* k) ).*exp( delta( 2: end) );
[delta_mesh,t_mesh]= meshgrid( delta,t) ; % ���񻯽ڵ����ͼ���ʱ���
gamma_mesh = meshgrid( gamma,t) ;
% ����Ȩϵ���ͼ���ʱ���% ��������� Laplace �任ֵ:
t=t';
ilt=0.4./t.*sum(real( gamma_mesh.* arrayfun ( f_s,delta_mesh./ t_mesh) ) ,2);
