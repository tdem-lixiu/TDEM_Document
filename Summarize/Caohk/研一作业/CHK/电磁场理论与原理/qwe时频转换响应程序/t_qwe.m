% ���ӳ�����Ҫ������qwe(���������Ʒ��е�Wynn's epsilon algorithm)
% �ο����ף�kerry key�ġ�Is the fast Hankel transform faster than quadrature?��
% ���룺n_gauss:gauss���ֵ����ϵ��������
%       n_qmax:����������ĸ�����
%       n�Ǵ���n��ز㣻
%       econ�������ĵ絼�ʣ�H�������Ĳ��
%       miu0�������ɿռ�ŵ��ʳ�����
%       I0�ǵ���ǿ��(A)��
%       a�Ǵ󶨻���Դ�İ뾶��
%       r�������ĵ�ľ��룻
%       z�ǲ�����߶ȣ�
%       h�ǽ�����Ȧ�ĸ߶ȣ�
%       tol_rel��qwe���������
%       tol_abs��qwe�ľ���������
%       t�Ǽ����ʱ���
% �����hz��ʱ������Ӧ��
% �м�����hz_f����Ƶ������Ӧ��
% ע�����
function hz=t_qwe(n_gauss,n_qmax,n,econ,H,miu0,I0,a,r,z,h,tol_rel,tol_abs,t)
% ---------------------------����ϵ��(������hankelϵ��)------------------------%
% �����������к͸�˹����ϵ������Ҫ�󲻱�ʱ�����Ҽ��㷽������ʱ
% ��(�ϵ�����pi/2����sin���������ֵ)�����ϵ��ʱ�ȶ����䣬����Ҫ���¼���
bx=pi/2*((1:n_qmax));
bx=bx';
[gx,gw]=getGaussQuadWeights(n_gauss);

gx   %�����˹�ڵ�λ��

% ��bx0������ִ�0��ʼ
bx0=1d-20;
bx0=(bx(1)-bx0)/2;
dif_gauss=diff(bx)/2;
dif_gauss=[bx0;dif_gauss];
% ������n_qmax��������n_gauss��gaussϵ������������x�ǹ���n_qmax*n_gauss�ľ���
% x��������������������Ҫ������xֵ
gx=gx';
x=repmat(dif_gauss,1,n_gauss).*(repmat(gx,n_qmax,1)-1)+repmat(bx,1,n_gauss);
gw=gw';
gw=repmat(gw,n_qmax,1);
bj_dhzdt=sin(x).*gw;
% bj�ǹ��ڴ洢�����е�g��������ϵ��
% ������n_qmax��������n_gauss��gaussϵ������������bj�ǹ���n_qmax*n_gauss�ľ���
% ---------------------------����ϵ��(������hankelϵ��)------------------------%
%%
% n_f=length(fres);
% n_disp=length(rx);
% hz=zeros(n_disp,n_f);
nt=length(t);
for i=1:1:nt  %nt��ʱ���ĸ���
    tt=t(i);
    %       T�ǽṹ���飬���鿴qwe�ӳ���Ľ���
    T(i)=qwe(@getkernel,tol_rel,tol_abs,n_qmax);
    %       n_ext�����е���Ѽ���ֵ
    n_ext=T(i).n;
    hz_n(i)=n_ext;
    hz(i)=T(i).extrap(n_ext);
end

hz_n  %���ÿ��ʱ������ʱ���õĲ��ֻ��ָ���

return;

%%
%------------------------------���ӳ������������㲿�ֻ��ֽ����----------------------------%
function y=getkernel(i)
% i����Ҫ�������������Fi
    kx=x/tt;
% r_gauss�Ǹ�˹����ʱ��������a��bת����-1��1������ʱ�������ĸ��ӳ�����
    r_gauss=dif_gauss(i)/tt;
% ������ʹ�õ�n_gauss���Ա���
    wt=kx(i,:);
% ����Ƶ������Ӧ
    hz_f=hankel_Gups(wt,r,a,I0,h,z,n,econ,H,miu0);
% ��ⲿ�ֻ��ֵĽ��
    y=bj(i,:)*imag(hz_f);
    y=-r_gauss*2*y/pi;
       
%------------------------------���ӳ������������㲿�ֻ��ֽ����----------------------------%
end

function y=getkernel_hz(i)
% i����Ҫ�������������Fi
    kx=x/tt;
% r_gauss�Ǹ�˹����ʱ��������a��bת����-1��1������ʱ�������ĸ��ӳ�����
    r_gauss=dif_gauss(i)/x(i,:);    %dhzdt�����ǳ���ʱ��tt,��hz�����ǳ���
% ������ʹ�õ�n_gauss���Ա���
    wt=kx(i,:);
% ����Ƶ������Ӧ
    hz_f=hankel_Gups(wt,r,a,I0,h,z,n,econ,H,miu0);
% ��ⲿ�ֻ��ֵĽ��
    y=bj(i,:)*imag(hz_f);
    y=-r_gauss*2*y/pi;
       
%------------------------------���ӳ������������㲿�ֻ��ֽ����----------------------------%
end
end