% 提示：w和r可以是一组数组，若r是数组，则它测量的是一条高度恒定的剖面线；
%       返回值hz是矩阵，行代表不同的测量点，列代表各频率域响应；
clear;
clc;
format long;
%++++++++++++++++++++++++++++++++++ 参数设置 +++++++++++++++++++++++++++++++++%
n=3;H(1:n)=[4.d1 4.d1 1.d10];econ(1:n)=[0.01 0.01 0.01];
z=0;h=0;
miu0=4.d-7*pi;
% I0是电流大小(A)
I0=1; 
%a代表回线源半径，r代表距离回线源中心的距离
a=100;  %5; 
r=0.1;   %linspace(0.1,10,51);
%flag判断是频率域还是时间域响应
%flag=1是时间域响应，2为单点的频率域响应，3为单频率下不同偏移的响应
flag=1;
% 当频率域响应时，w需要给出，而时间域时，是不需要给出w
% 计算频率域相关的子程序有：wsamp：给出对数均匀采样的频率；
%                         draw_rhz：给出固定频率域下偏移距和hz的关系图；
%                         draw_whz：给出固定偏移距下的频率域响应以及关系图；
% 注意：如果想计算多个偏移点的频率域响应，则就不要调用draw_rhz和draw_whz函数即可；
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
%   画图
    plot(log10(t),log10(dBzdt));
    title('Hankel航空瞬变电磁法');
    xlabel('时间 (s)');
    ylabel('-dBzdt (T/s)');
    legend('-dBzdt')
    set(gcf,'paperposition',[2 2 4.3 5]);
    %%
%   保存数据
    outfile=strcat(num2str(n),'层','_',num2str(a),'_',num2str(r),'_',date,'.txt');
    fid=fopen(outfile,'wt');
    fprintf(fid,'%s%e %s%e','I0=',I0,'r=',r);
    fprintf(fid,'\n');
    fprintf(fid,'%s','每层厚度分别为：');
    for k=1:n
        fprintf(fid,'%e\t',H(k));
    end
    fprintf(fid,'\n');
    fprintf(fid,'%s','每层电导率分别为：');
    for k=1:n
        fprintf(fid,'%e\t',econ(k));
    end
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','正演数据：');
    nt=length(t);
    for k=1:nt
        fprintf(fid,'%e  %e',t(k),dBzdt(k));
        fprintf(fid,'\n');
    end
    fclose(fid);

end