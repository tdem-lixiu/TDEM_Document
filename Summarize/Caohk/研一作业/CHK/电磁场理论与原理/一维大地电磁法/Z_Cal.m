% �ó����������Ļ��ߺ�qwe��Z_cal(10.05)�Ļ����ϸĽ������ٶȵ��ӳ���
% ʱ�䣺2018/11/29�����ߣ��ܻ���
% ��;������������迹
% �ο����ס��������������185ҳ
% ���룺w��Ƶ����������cond��n��ĵ絼����������miu0����մŵ��ʣ�h��n��ĺ����������
% �����zu�Ǹ���Ƶ�ʵ�n��ı����迹����ͬ�����ǲ�ͬƵ�ʵģ���ͬ�����ǲ�ͬ����ʱ�ı������迹��
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