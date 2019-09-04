% ��ʾ��w��r������һ�����飬��r�����飬������������һ���߶Ⱥ㶨�������ߣ�
%       ����ֵhz�Ǿ����д���ͬ�Ĳ����㣬�д����Ƶ������Ӧ��
clear;
clc;
format long;
%++++++++++++++++++++++++++++++++++ �������� +++++++++++++++++++++++++++++++++%
n=3;H(1:n)=[4.d1 4.d1 1.d10];econ(1:n)=[0.01 0.01 0.01];
z=0;h=0;
miu0=4.d-7*pi;
% I0�ǵ�����С(A)
I0=1; 
%a�������Դ�뾶��r����������Դ���ĵľ���
a=100;  %5; 
r=0.1;   %linspace(0.1,10,51);
%flag�ж���Ƶ������ʱ������Ӧ
%flag=1��ʱ������Ӧ��2Ϊ�����Ƶ������Ӧ��3Ϊ��Ƶ���²�ͬƫ�Ƶ���Ӧ
flag=1;
% ��Ƶ������Ӧʱ��w��Ҫ��������ʱ����ʱ���ǲ���Ҫ����w
% ����Ƶ������ص��ӳ����У�wsamp�������������Ȳ�����Ƶ�ʣ�
%                         draw_rhz�������̶�Ƶ������ƫ�ƾ��hz�Ĺ�ϵͼ��
%                         draw_whz�������̶�ƫ�ƾ��µ�Ƶ������Ӧ�Լ���ϵͼ��
% ע�⣺����������ƫ�Ƶ��Ƶ������Ӧ����Ͳ�Ҫ����draw_rhz��draw_whz�������ɣ�
%%
if flag==2
    w=wsamp(1d-2,1d6,131);
    r=0.1;
    hz=draw_whz(w,r,a,I0,h,z,n,econ,H,miu0);
elseif flag==3
    w=25/pi/2;
    r=linspace(0.01*a,2*a,100);
    hz_f=draw_rhz(w,r,a,I0,h,z,n,econ,H,miu0);
elseif flag==1
    t=tsamp(1.d-5,1.d-1,41);
    tic;
    dhzdt=tft(r,a,I0,h,z,n,econ,H,t,miu0);
    toc;
    dBzdt=dhzdt*miu0;
    %%
%   ��ͼ
    plot(log10(t),log10(dBzdt));
    title('Hankel����˲���ŷ�');
    xlabel('ʱ�� (s)');
    ylabel('-dBzdt (T/s)');
    legend('-dBzdt')
    set(gcf,'paperposition',[2 2 4.3 5]);
    %%
%   ��������
    outfile=strcat(num2str(n),'��','_',num2str(a),'_',num2str(r),'_',date,'.txt');
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
        fprintf(fid,'%e  %e',t(k),dBzdt(k));
        fprintf(fid,'\n');
    end
    fclose(fid);

end