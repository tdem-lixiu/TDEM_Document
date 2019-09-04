% ��ʾ��w��r������һ�����飬��r�����飬������������һ���߶Ⱥ㶨�������ߣ�
%       ����ֵhz�Ǿ����д���ͬ�Ĳ����㣬�д����Ƶ������Ӧ��
clear;
clc;
format long;
%++++++++++++++++++++++++++++++++++ �������� +++++++++++++++++++++++++++++++++%
n=3;H(1:n)=[4.d1 4.d1 1.d20];econ(1:n)=[0.01 0.01 0.01];
z=0;h=0;
miu0=4.d-7*pi;
% I0�ǵ�����С(A)
I0=1; 
%a�������Դ�뾶��r����������Դ���ĵľ���
a=100;  
%%
% ��ͼ
t=tsamp(1.d-4,1.d2,61);
hz_t=tft(a,I0,n,econ,H,t,miu0);
bz_t=hz_t*miu0;
plot(log10(t),log10(bz_t));
title('���Ļ��߷�');
xlabel('ʱ�� (s)');
ylabel('-dBzdt (T/s)');
legend('-dBzdt')
set(gcf,'paperposition',[2 2 4.3 5]);
%%
% �������
outfile=strcat(num2str(n),'��','_',num2str(a),'_',date,'.txt');
fid=fopen(outfile,'wt');
fprintf(fid,'%s%e %s%e','I0=',I0,'a=',a);
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