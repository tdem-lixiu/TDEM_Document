% ΢��������
% clc;
% clear;
% h=10.^-(1:9);
% format long;
% f1=(exp(h)-exp(0))./h;
% f2=(exp(h)-exp(-h))./(2*h);
% f=exp(0);
% error1=f-f1
% error2=f-f2

% ��������
% clc;
% clear;
% syms x;
% f=sin(3*x);
% f1=diff(f)

% 5.1ʵ��
% clc;
% clear;
% f=@(x) sin(x)-cos(x);
% h=10.^-(1:12);
% %f1=(f(h)-f(-h))./(2.*h);
% f1=(f(h)-f(0))./h;
% f2=1;
% plot(log10(h),log10(abs(f1-f2)));
% grid on;

% 5.5 ʵ��
% clc;
% clear;
% h=10.^-(1:12);
% f=@(x) cos(x);
% f1=(f(h)+f(-h)-2.*f(0))./(h.*h);
% f2=-1;
% plot(log10(h),log10(abs(f1-f2)));
% grid on;

% 5.2ʵ��
% clc;clear;
% f=@(x) 1./sqrt(x);
% a=1;
% b=0;
% n=1000;
% y=cnc(f,b,a,n,3)

% ���˫beseel����
% ��ֵ���ֹ���H1n,1
% clc;
% clear;
% format long;
% % a=1;
% b=1;
% x0=0;
% x1=10;
% k=6000;
% y2=zeros(1,k);
% time=zeros(1,200);
% for a=1:200
% f=@(x) besselj(1,a.*x).*besselj(0,b.*x);
% y1=cnc(f,x0,x1,1,2);
% y2(1)=abs(y1);
% for n=2:k
% y1=cnc(f,x0,x1,n,2);
% y2(n)=abs(y1);
% if abs(y2(n)-y2(n-1))<1.d-5*y2(n)
%     time(a)=n;
%     break;
% end
% end
% n
% end
% plot(1:200,time)
% grid on;



% %----------------------------------- ���˫beseel���� -------------------------%
% % ��ֵ���ֹ���H1n,1
% clc;
% clear;
% format long;
% a=2;
% b=1;
% % ����һ���������Ļ���������
% x0=0;
% xmin=min(a,b);
% x1=10/xmin;   
% % ����һ���������Ļ���������
% % c=25.0d0;
% f=@(x) besselj(1,a.*x).*besselj(0,b.*x);%x.*exp(-x.*x.*c.*c).*besselj(1,a.*x).*besselj(1,b.*x);
% n=8*(ceil(a*b*x1)+1)*2;
% y1=cnc(f,x0,x1,n,2);
% 
% filter_n=250;
% delt=log(10)/20;
% k1=a+b;      %����kֵ
% k2=a-b;
% sign=1;
% if b>a
% k2=b-a;      %����kֵ
% sign=-1;
% end
% n1=floor(log(k1*x1)/delt)+150;   %������ʼ�˲���      %�޸�
% n2=floor(log(k2*x1)/delt)+150;   %������ʼ�˲���
% x_cos(1:filter_n-n1+1)=exp(delt.*((n1:filter_n)-150))./k1;  %�޸�
% x_sin(1:filter_n-n2+1)=exp(delt.*((n2:filter_n)-150))./k2;
% x_cos(1)
% x_sin(1)
% x1
% 
% % g(x)����˺���
% g=@(x) 1.d0./x; %exp(-x.*x.*c.*c);
% % g(x)����˺���
% % �����ص��Ļ�������
% gc_ol=@(x) -1./(pi*sqrt(a*b)).*cos(x.*k1).*g(x);
% gs_ol=@(x) 1./(pi*sqrt(a*b)).*sin(x.*k2).*g(x).*sign;
%    %���ص���������ֳ�n_ol��������
% nc_ol=ceil(x1*k1);     %���ص���������ֳ�n_ol��������
% ns_ol=ceil(x1*k2);
%    %���ص���������ֳ�n_ol��������
% fc_ol=cnc(gc_ol,x_cos(1),x1,nc_ol,2);
% fs_ol=cnc(gs_ol,x_sin(1),x1,ns_ol,2);
% % �����ص��Ļ�������
% 
% % �����Һ������ֽ����������
% sc_cos=constant_cos;
% sc_cos=sc_cos';
% fc=-1./(pi*sqrt(a*b)).*sqrt(pi/2)./k1.*g(x_cos)*sc_cos(n1:filter_n);  %1��n1
% % �����Һ������ֽ����������
% % �����Һ������ֽ����������
% sc_sin=constant_sin;
% sc_sin=sc_sin';
% fs=1./(pi*sqrt(a*b)).*sqrt(pi/2)./k2.*g(x_sin)*sc_sin(n2:filter_n)*sign;   %1��n2
% % �����Һ������ֽ����������
% 
% %�ڶ������������(���ص�����)
% y1
% y2=fc+fs
% %�ڶ�������ص�������
% y3=fc_ol+fs_ol
% % hΪ���ս��
% h=y1+y2-y3
% %----------------------------------- ���˫beseel���� -------------------------%

% 5.2 ��7��
% clc;
% clear;
% format long;
% a=0;
% b=1; %pi/2;
% f=@(x) atan(x)./x; %(exp(x)-1)./sin(x); %x./sin(x);
% y=cnc(f,a,b,16,3);

% 5.4 ����
% clc;
% clear;
% format long;
% f=@(x) 1+sin(exp(3*x));
% [int,n]=adapquad(f,-1,1,0.005,2)

% 6.1 ����
% eeuler(0,1,1,10)