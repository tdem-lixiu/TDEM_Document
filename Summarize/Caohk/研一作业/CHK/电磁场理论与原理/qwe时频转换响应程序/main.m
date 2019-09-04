% ���ߣ��ܻ��ƣ�ʱ�䣺2018/12/11��
% ������λ��������ѧ��
% ��ʾ���ó����ǹ��ں��յ�˲���ŷ�
%       ʱƵת����QWE������hankel�任��Gupstasarma�㷨��J1��140λ�˲�ϵ��;
% ����˵����n���ǵز������H�Ǹ��ز�ĺ�ȣ�econ�Ǹ��ز�ĵ絼�ʣ�
%          z���ǽ��ܵ���z���ϵ�λ�ã�h���Ƿ�����Ȧ�ĸ߶ȣ�
%          miu0������մŵ��ʣ�I0��������С��
%          a����Բ�η�����Ȧ�뾶��r�ǽ��ܵ�ƫ�����ĵľ��룻
% �ӳ���˵����tsamp�Ƕ�ʱ����ж����ȼ��ȡ����wsamp��Ƶ�ʽ��ж����ȼ��ȡ���� 
%            hankel_Gups������Gups�����˲�������Ƶ�������⣻
%            GupsJ1_140�������˲�ϵ����
%            t_qwe������qwe��������ʱƵת����getGaussQuadWeights����ȡ��˹ϵ����
%            qwe������qwe�㷨��analysis�Ǽ������ĵ���Ȱ�ռ�Ľ����⣻
clear;
clc;
format long;
%++++++++++++++++++++++++++++++++++ �������� +++++++++++++++++++++++++++++++++%
n=3;H(1:n)=[4.d1 4.d1 1.d20];econ(1:n)=[0.001 0.001 0.001];
z=0;h=0;
miu0=4.d-7*pi;
% I0�ǵ�����С(A)
I0=1; 
%a�������Դ�뾶��r����������Դ���ĵľ���
a=1000;  %5; 
r=0.1;    %linspace(.1,10,51);

% flag=1����ʾֻ������ֵ���ͼ��flag=2��ʾ�������������ֵ���ͼ�Լ����ͼ����������ֵ
flag=2;
% ֻ�м���ʱ������Ӧʱ��t������
t=tsamp(1.d-6,1.d2,41);
% --------------------------------�������޸ĵĳ���-----------------------------%
% n_gauss�����˹����ʱ�Ļ���ϵ��������
% һ��9���������㾫��Ҫ����Ҫ��ͬ�ľ�����Ҫ�����޸�
n_gauss=11;
% n_qmax�ǻ������е���������һ�㲻���޸ģ�50���㹻���㾫��Ҫ���
%       ����n_qmax=14
n_qmax=14;  %��ֵ�����Ų���Ƶ�ʷ�Χ
% ����˵������n_qmax=10ʱ�������������1%���£���С��10ʱ�����Ѹ������
% ��ʹn_gauss�ٴ�Ҳ���ã�������n_qmax��Сʱn_gauss������ú�����
% --------------------------------�������޸ĵĳ���-----------------------------%
% relTol��qwe���������absTol��qwe�������������ݾ���Ҫ����Խ����ʵ��޸�
% ��relTol>1d12ʱ�����ĸı������Եظı������ٶ�
relTol = 1.d-6;%1d-8;
absTol = 1.d-20;%1d-25;

%++++++++++++++++++++++++++++++++++ �������� +++++++++++++++++++++++++++++++++%
%%
% ����Ҫ����ĺ�����ͻ�ͼ
tic;
hz_t=t_qwe(n_gauss,n_qmax,n,econ,H,miu0,I0,a,r,z,h,relTol,absTol,t);
toc;
bz_t=hz_t*miu0;
if flag==1
plot(log10(t),log10(bz_t));
xlabel('time (s)');
ylabel('dBzdt (T/s)');
title('QWEʱƵת����ʱ������Ӧ');
legend('QWE for loop source');
set(gcf,'paperposition',[2 2 4.3 5]);
end
%%
% �������
outfile=strcat(num2str(n),'��','_',num2str(a),'_',num2str(r),'t_',date,'.txt');
fid=fopen(outfile,'wt');
fprintf(fid,'%s%e %s%e','I0=',I0,'r=',r);
fprintf(fid,'\n');
fprintf(fid,'%s','ÿ���ȷֱ�Ϊ��');
for k=1:n
    fprintf(fid,'%e\t',H(k));
end
fprintf(fid,'\n');
fprintf(fid,'%s','ÿ��絼�ʷֱ�Ϊ��');
for k=1:n
    fprintf(fid,'%e\t',econ(k));
end
fprintf(fid,'\n');
fprintf(fid,'%s\n','�������ݣ�');
nt=length(t);
for k=1:nt
    fprintf(fid,'%e  %e',t(k),bz_t(k));
    fprintf(fid,'\n');
end
fclose(fid);
% �������

%%
% ���ӱȽϲ���
aecon=0.001;  %�Ǿ��Ȱ�ռ�ĵ絼�� 
analy_t=analysis(aecon,a,I0,miu0,t);
if flag==2
    subplot(2,1,1);
    plot(log10(t),log10(analy_t),'-k',log10(t),log10(bz_t),'bo');
    xlabel('time (s)');
    ylabel('dBzdt (T/s)');
    title('QWEʱƵת����ʱ������Ӧ');
    legend('anlysis for the loop source','QWE for loop source');
    
    subplot(2,1,2);
    error_t=abs(analy_t-bz_t)./analy_t*100;
    plot(log10(t),log10(error_t));
    xlabel('time (s)');
    ylabel('��� (%)');
    title('QWEʱƵת�������');
    legend('QWE for loop source');    
end



% �������ɣ��ȹ۲�t_qwe�ӳ�����n_ext������δ����n_qmax����˵������Ҫ��n_qmax����
%          �޸ģ�Ȼ��ɶ�relTol��absTol�����޸ģ�����Сʱͼ�任��˵��ʱ�ô���
%          ���⣬��һ����˵ʱ�㹻��һ����˵��������Խ�߻�����Ҫ��ʱ��Խ��n_gauss
%          ӦԽ����������㹻�ľ���

% ����ɸ��Ƶĵط���
