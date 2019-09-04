% ���ӳ�����Ҫ������qwe(���������Ʒ��е�Wynn's epsilon algorithm)
% �ο����ף�kerry key�ġ�Is the fast Hankel transform faster than quadrature?��
% ���룺n_gauss:gauss���ֵ����ϵ��������
%       n_qmax:����������ĸ�����
%       nu:bessel�����Ľ�����
%       fres��Ƶ�ʣ�n�Ǵ���n��ز㣻
%       econ�������ĵ絼�ʣ�H�������Ĳ��
%       miu0�������ɿռ�ŵ��ʳ�����
%       I0�ǵ���ǿ��(A)��
%       a�Ǵ󶨻���Դ�İ뾶��
%       rx�������ĵ�ľ��룻
%       z�ǲ�����߶ȣ�
%       h�ǽ�����Ȧ�ĸ߶ȣ�
%       tol_rel��qwe���������
%       tol_abs��qwe�ľ���������
% �����hz��Ƶ������Ӧ��
% �м�����m�����������������Ա�����
% ע�����
function hz=f_qwe(n_gauss,n_qmax,nu,fres,n,econ,H,miu0,I0,a,rx,z,h,tol_rel,tol_abs)
% ---------------------------����ϵ��(������hankelϵ��)------------------------%
% �����������к͸�˹����ϵ������Ҫ�󲻱�ʱ�����Ҽ��㷽������ʱ
% ��(�ϵ�����Jn����㲻��)�����ϵ��ʱ�ȶ����䣬����Ҫ���¼���
bx=besselroot(nu,n_qmax);
[gx,gw]=getGaussQuadWeights(n_gauss);
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
bj=besselj(nu,x).*gw;
% bj�ǹ��ڴ洢�����е�g��������ϵ��
% ������n_qmax��������n_gauss��gaussϵ������������bj�ǹ���n_qmax*n_gauss�ľ���
% ---------------------------����ϵ��(������hankelϵ��)------------------------%
%%
n_f=length(fres);
n_disp=length(rx);
hz=zeros(n_disp,n_f);
for k=1:1:n_disp    %rx�Ǵ洢ƫ�ƾ��������
    r=rx(k);
    for i=1:1:n_f  %fres�Ǵ洢Ƶ�ʵ�������
        w=fres(i);
%       T�ǽṹ���飬���鿴qwe�ӳ���Ľ���
        T(k,i)=qwe(@getkernel,tol_rel,tol_abs,n_qmax);
%       n_ext�����е���Ѽ���ֵ
        n_ext=T(k,i).n;
        hz(k,i)=T(k,i).extrap(n_ext);
    end
end
return;

%%
%------------------------------���ӳ������������㲿�ֻ��ֽ����----------------------------%
function y=getkernel(i)
% i����Ҫ�������������Fi
    kx=x/a;
% r_gauss�Ǹ�˹����ʱ��������a��bת����-1��1������ʱ�������ĸ��ӳ�����
    r_gauss=dif_gauss(i)/a;
% ������ʹ�õ�n_gauss���Ա���
    m=kx(i,:);
% ����˺������ֵĲ��迹���������Ա����任��
    [zu,~,zd0]=Z_cal;
    C=(exp(-m.*abs(z+h))+(zu(1,:)-zd0)./(zu(1,:)+zd0).*exp(m.*(z-h))).*m/2;
% �ж϶ϵ�ʱȡ���ĸ�bessel����
    if nu==1
        y=sum(C.*besselj(0,m*r).*bj(i,:));
    end
    if nu==0;
        y=sum(C.*besselj(1,m*r).*bj(i,:));
    end
    y=r_gauss*I0*a*y;
    
    
% ------------------------------���㲨�迹-------------------------------------%
% ��Ƕ�׺����Ǽ��㲨�迹�ĳ������ߣ��ܻ��ƣ�ʱ�䣺2018.10.4��
% �ο����ף���˲���Ų����������Ӧ�á�
% ���룺w��Ƶ�ʣ�n�Ǵ���n��ز㣻
%       econ�������ĵ絼�ʣ�H�������Ĳ��
%       m�����������������Ա������б�����
%       miu�������ɿռ�ŵ��ʳ�����
% �����zu�ǲ��迹�ϱ�ֵ��zd�����迹�±�ֵ��
%       zd0�ǿ������迹��
%       ��n��n_m�У��д���ÿ������ӣ��д������m����ʱ����ֵ;
function [zu,zd,zd0]=Z_cal
n_m=length(m);
u=zeros(n,n_m);
zd=u;
for ii=1:1:n
    u(ii,1:n_m)=sqrt(m.*m-1i*w*econ(ii)*miu0);
end
for ii=1:1:n
    zd(ii,1:n_m)=-1i*w./u(ii,:)*miu0;
end
zu(n,:)=zd(n,:);
zd0=-1i*w*miu0./m;
for ii=n-1:-1:1
   zu(ii,:)=zd(ii,:).*(zu(ii+1,:)+zd(ii,:).*tanh(u(ii,:).*H(ii)))./(zd(ii,:)+zu(ii+1,:).*tanh(u(ii,:).*H(ii)));
end
end
% ------------------------------���㲨�迹-------------------------------------%
end
%------------------------------���ӳ������������㲿�ֻ��ֽ����----------------------------%

end