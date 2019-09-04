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
a=100;  %5; 
r=0.1;    %linspace(.1,10,51);

%flag判断是频率域还是时间域响应
%flag=1是时间域响应，2为单点的频率域响应，3为单频率下不同偏移的响应
flag=2;

% 当频率域响应时，w需要给出，而时间域时，是不需要给出w
% 计算频率域相关的子程序有：wsamp：给出对数均匀采样的频率；
%                         draw_rhz：给出固定频率域下偏移距和hz的关系图；
%                         deaw_whz：给出固定偏移距下的频率域响应以及关系图；


% 只有计算时间域响应时，t才有用
if flag==1
    t_a=1d-5;
    t_b=1d-1;
    t_n=41;
    t=tsamp(t_a,t_b,t_n);
elseif flag==2
    w=wsamp(1d-6,1d8,141);  %
elseif flag==3
    w=1d-1;
    r=linspace(.01*a,2*a,50);
    %注意：这里若在奇点处明显跳跃了，说明n_qmax取得不够大，是需要适当进行调整
    %      从试验来说，越接近奇点，所需要得n_qmax越大!
end
% --------------------------------不建议修改的常数-----------------------------%
% n_gauss是求高斯积分时的积分系数个数，
% 对于频率域来说，一般9个足以满足精度要求，一般不修改
% 但对于时间域响应，需要进行相应的调整
if flag==1
    n_gauss=30;
else 
    n_gauss=9;
end
% n_qmax是积分序列的最大个数，太大可能会拖慢计算速度，但太小会达不到所要求的精度
%       建议与relTol和absTol相互协调修改
% 当n_qmax远离边框时计算所需的积分部分很小，一般在10左右，靠近边框时会显著增加
n_qmax=200;
% nu是以第nu阶的第一类bessel函数的零点作为断点，不修改
nu=1;
% --------------------------------不建议修改的常数-----------------------------%
% relTol是qwe相对容忍误差，absTol是qwe绝对容忍误差，根据精度要求可以进行适当修改
% 当relTol>1d12时，它的改变能明显地改变运算速度
relTol = 1d-8;
absTol = 1d-20;
% 调用draw_rhz子程序时是数组，否则为一个数

%++++++++++++++++++++++++++++++++++ 参数设置 +++++++++++++++++++++++++++++++++%
%%
% 调用要计算的函数类
if flag==2
hz=draw_whz(n_gauss,n_qmax,nu,w,n,econ,H,miu0,I0,a,r,z,h,relTol,absTol);  %
elseif flag==3
hz=draw_rhz(n_gauss,n_qmax,nu,w,n,econ,H,miu0,I0,a,r,z,h,relTol,absTol);
elseif flag==1
nr=length(r);
for k=1:1:nr
hz_t=tft_qwe(n_gauss,n_qmax,nu,t,n,econ,H,miu0,I0,a,r(k),z,h,relTol,absTol);
bz_t=hz_t*miu0;   
%%
%  画图
figure;
plot(log10(t),log10(bz_t),'ko');
legend('dBzdt');
xlabel('Time (s)');
ylabel('dBzdt (T)');
title('QWE for loop source');
% set(gca,'ytick',10.^[-16:1:0]);
set(gcf,'paperposition',[2 2 4.3 5]);
%%
% 文件输出
outfile=strcat(num2str(n),'层','_',num2str(a),'_',num2str(r(k)),'_',date,'.txt');
fid=fopen(outfile,'wt');
fprintf(fid,'%s%e %s%e','I0=',I0,'r=',r(k));
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
end  %end do 71
end %end if

% 程序结束

% 注意事项：一般来说对于频率域，n_gauss=9精度时足够了，但对于时间域来说并不一定
%          尤其对于高阻的晚期来说，电阻率越大，其误差也会越大，出现误差的时间会
%          越早。
% 调整技巧：先观测f_qwe子程序中n_ext，如若未超过n_qmax，则说明不需要对n_qmax进行
%          修改，然后可对relTol，absTol进行修改，若变小时图变换大，说明时该处的
%          问题，但一般来说时足够的。对于时间域，可根据电阻率适当修改n_gauss，一
%          般来说，电阻率越高或者需要的时期越晚，n_gauss应越大

% 程序可改善的地方：
% 1.返回计算所使用中n_qmax的最大积分数量；
% 2.为了模块化，导致在进行时间域计算时，n_qmax个积分重复计算
% 3.根据《勘查地球物理学》书中所说的，在数值计算时往往前面几个积分需要更多的高斯积分节点，
%   而后面的所需高斯积分节点要少些，而本程序这里是采用的是使用统一数量的节点数，所以理论上
%   可以分开使用不同的高斯节点从而加快运算速度。
% 4.时频转换是否也能用qwe方法实现？