% 该程序是在中心回线和qwe的Z_cal(10.05)的基础上改进运算速度的子程序
% 时间：2018/11/29，作者：曹华科
% 用途：计算表征波阻抗
% 参考文献《勘查地球物理》第185页
% 输入：w是频率行向量；cond是n层的电导率行向量；miu0是真空磁导率；h是n层的厚度行向量；
% 输出：zu是各个频率的n层的表征阻抗，不同列数是不同频率的，不同行数是不同层数时的表征波阻抗；
function zu=Z_Cal(w,cond,miu0,h)
nw=length(w);
w=w';
n=length(cond);
cond=repmat(cond,nw,1);
h=repmat(h,nw,1);
w=repmat(w,1,n);
kk=-1i*miu0*cond.*w;
k=sqrt(kk);
zd=miu0*w./k;
zu(:,n)=zd(:,n);
for i=n-1:-1:1
   zu(:,i)=zd(:,i).*(zu(:,i+1)+zd(:,i).*((exp(1i*k(:,i).*h(:,i))- ...
   exp(-1i*k(:,i).*h(:,i)))./(exp(1i*k(:,i).*h(:,i)+exp(-1i*k(:,i).*h(:,i))))))./ ...
   (zd(:,i)+zu(:,i+1).*((exp(1i*k(:,i).*h(:,i))- ...
   exp(-1i*k(:,i).*h(:,i)))./(exp(1i*k(:,i).*h(:,i)+exp(-1i*k(:,i).*h(:,i))))));
end
end