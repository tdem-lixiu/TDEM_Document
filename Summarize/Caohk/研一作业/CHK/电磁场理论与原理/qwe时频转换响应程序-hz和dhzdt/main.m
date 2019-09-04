% 作者：曹华科；时间：2018/12/11；
% 工作单位：长安大学；
% 提示：该程序是关于航空的瞬变电磁法
%       时频转换是QWE方法，hankel变换是Gupstasarma算法得J1的140位滤波系数;
% 参数说明：n：是地层层数；H是各地层的厚度；econ是各地层的电导率；
%          z：是接受点在z轴上的位置，向上为负；h：是发射线圈的高度；
%          miu0：是真空磁导率；I0：电流大小；
%          a：是圆形发射线圈半径；r是接受点偏移中心的距离；
% 子程序说明：tsamp是对时间进行对数等间距取样；wsamp对频率进行对数等间距取样； 
%            hankel_Gups：利用Gups数字滤波法进行频率域的求解；
%            GupsJ1_140：调用滤波系数；
%            t_qwe：利用qwe方法进行时频转换；getGaussQuadWeights：获取高斯系数；
%            qwe：调用qwe算法；analysis是计算中心点均匀半空间的解析解；
clear;
clc;
format long;
%++++++++++++++++++++++++++++++++++ 参数设置 +++++++++++++++++++++++++++++++++%
n=3;H(1:n)=[1.d2 1.d1 1.d2];econ(1:n)=[0.01 0.01 0.01];
z=0;h=0;
miu0=4.d-7*pi;
% I0是电流大小(A)
I0=1; 
%a代表回线源半径，r代表距离回线源中心的距离
a=100;  %5; 
r=0.01;    %linspace(.1,10,51);

% flag=1，表示只画出数值解的图，flag=2表示画出解析解和数值解的图以及误差图，并输出误差值
flag=2;
component=1; %计算分量，0代表计算bz和dbzdt分量,1代表只计算dbzdt分量,2代表只计算bz分量
% 只有计算时间域响应时，t才有用
t=tsamp(1.d-6,1.d-1,51);
% --------------------------------不建议修改的常数-----------------------------%
% n_gauss是求高斯积分时的积分系数个数，
% 一般9个足以满足精度要求，需要不同的精度需要进行修改
n_gauss=9;
% n_qmax是积分序列的最大个数，一般不用修改，50是足够满足精度要求的
%       建议n_qmax=14
n_qmax=11;  %该值象征着采样频率范围
% 经验说明：当n_qmax=10时，基本上误差在1%以下，当小于10时，误差迅速增大，
% 即使n_gauss再大也无用，所以在n_qmax较小时n_gauss起的作用很有限
% --------------------------------不建议修改的常数-----------------------------%
% relTol是qwe相对容忍误差，absTol是qwe绝对容忍误差，根据精度要求可以进行适当修改
% 当relTol>1d12时，它的改变能明显地改变运算速度
relTol = 1.d-8;%1d-8;
absTol = 1.d-20;%1d-25;

%++++++++++++++++++++++++++++++++++ 参数设置 +++++++++++++++++++++++++++++++++%
%%
% 调用要计算的函数类和画图
tic;
[dhzdt_t,hz_t]=t_qwe(n_gauss,n_qmax,n,econ,H,miu0,I0,a,r,z,h,relTol,absTol,t,component);
toc;
bz_t=hz_t*miu0;
dbzdt_t=dhzdt_t*miu0;
if flag==1
    if component==2
        y=bz_t;
    else
        y=dbzdt_t;
    end
    plot(log10(t),log10(y));
    xlabel('time (s)');
    if component==2
        ylabel('Bz (T/s)');
    else
        ylabel('dBzdt (T/s)');
    end
    title('QWE时频转换的时间域响应');
    legend('QWE for loop source');
    set(gcf,'paperposition',[2 2 4.3 5]);
end
%%
% 输出数据
outfile=strcat(num2str(n),'层','_',num2str(a),'_',num2str(r),'t_',date,'.txt');
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
if component==1
for k=1:nt
    fprintf(fid,'%e  %e',t(k),dbzdt_t(k));
    fprintf(fid,'\n');
end
elseif component==2
    for k=1:nt
        fprintf(fid,'%e  %e',t(k),bz_t(k));
        fprintf(fid,'\n');
    end
elseif component==0
    for k=1:nt
        fprintf(fid,'%e  %e  %e',t(k),bz_t(k),dbzdt_t);
        fprintf(fid,'\n');
    end
end
fclose(fid);
% 程序结束

%%
% 附加比较部分
aecon=econ(end);  %是均匀半空间的电导率 

[analy_dhzdt,analy_hz]=analysis(aecon,a,I0,miu0,t,component);
if flag==2
    if component == 1 
        y=dbzdt_t;
        analy_t=analy_dhzdt;
    elseif component == 2
        y=bz_t;
        analy_t=analy_hz;
    end
    if component == 1 || component==2
        if component==1
            ylabel('dBz/dt (T/s)');
        elseif component==2
            ylabel('Bz (T)');
        end
        subplot(2,1,1);
        plot(log10(t),log10(analy_t),'-k',log10(t),log10(y),'bo');
        xlabel('time (s)');
        title('QWE时频转换的时间域响应');
        legend('anlysis for the loop source','QWE for loop source');
        
        subplot(2,1,2);
        error_t=abs(analy_t-y)./analy_t*100;
        plot(log10(t),log10(error_t));
        xlabel('time (s)');
        ylabel('误差 (%)');
        title('QWE时频转换的误差');
        legend('QWE for loop source');
        errfile=strcat(num2str(a),'_',num2str(r),'t_',date,'err.txt');
        fed=fopen(errfile,'wt');
        for k=1:nt
            fprintf(fed,'%e  %e',t(k),error_t(k));
            fprintf(fed,'\n');
        end
        fclose(fed);
    elseif component==0
        subplot(2,2,1);
        plot(log10(t),log10(analy_dhzdt),'-k',log10(t),log10(dbzdt_t),'bo');
        xlabel('time (s)');
        ylabel('dBz/dt (T/s)');
        title('QWE时频转换的时间域响应');
        legend('anlysis for the loop source','QWE for loop source');
                
        subplot(2,2,2);
        plot(log10(t),log10(analy_hz),'-k',log10(t),log10(bz_t),'bo');
        xlabel('time (s)');
        ylabel('Bz (T)');
        title('QWE时频转换的时间域响应');
        legend('anlysis for the loop source','QWE for loop source');
        
        subplot(2,2,3);
        error_dhzdt=abs(analy_dhzdt-dbzdt_t)./analy_dhzdt*100;
        plot(log10(t),log10(error_dhzdt));
        xlabel('time (s)');
        ylabel('误差 (%)');
        title('QWE时频转换的误差');
        legend('QWE for loop source');       
        
        subplot(2,2,4);
        error_hz=abs(analy_hz-bz_t)./analy_hz*100;
        plot(log10(t),log10(error_hz));
        xlabel('time (s)');
        ylabel('误差 (%)');
        title('QWE时频转换的误差');
        legend('QWE for loop source'); 
    end
end



% 调整技巧：先观测t_qwe子程序中n_ext，如若未超过n_qmax，则说明不需要对n_qmax进行
%          修改，然后可对relTol，absTol进行修改，若变小时图变换大，说明时该处的
%          问题，但一般来说时足够的一般来说，电阻率越高或者需要的时期越晚，n_gauss
%          应越大才能满足足够的精度

% 程序可改善的地方：
