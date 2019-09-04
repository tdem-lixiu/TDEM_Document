% 提示：w和r可以是一组数组，若r是数组，则它测量的是一条高度恒定的剖面线；
%       返回值hz是矩阵，行代表不同的测量点，列代表各频率域响应；
clear;
clc;
format long;
%++++++++++++++++++++++++++++++++++ 参数设置 +++++++++++++++++++++++++++++++++%
n=3;H(1:n)=[4.d1 4.d1 1.d20];econ(1:n)=[0.01 0.01 0.01];
z=0;h=0;
miu0=4.d-7*pi;
% I0是电流大小(A)
I0=1; 
%a代表回线源半径，r代表距离回线源中心的距离
a=100;  
%%
% 画图
t=tsamp(1.d-4,1.d2,61);
hz_t=tft(a,I0,n,econ,H,t,miu0);
bz_t=hz_t*miu0;
plot(log10(t),log10(bz_t));
title('中心回线法');
xlabel('时间 (s)');
ylabel('-dBzdt (T/s)');
legend('-dBzdt')
set(gcf,'paperposition',[2 2 4.3 5]);
%%
% 输出数据
outfile=strcat(num2str(n),'层','_',num2str(a),'_',date,'.txt');
fid=fopen(outfile,'wt');
fprintf(fid,'%s%e %s%e','I0=',I0,'a=',a);
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
    fprintf(fid,'%e  %e',t(k),bz_t(k));
    fprintf(fid,'\n');
end
fclose(fid);