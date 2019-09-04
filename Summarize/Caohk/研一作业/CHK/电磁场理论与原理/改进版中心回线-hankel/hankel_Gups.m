% hz_f��nw��nr�еľ��󣬼���ͬ���д���ͬ��Ƶ����Ӧ������ͬ���д���ͬ��λ����Ӧ
% ���룺w����������r��������
function [hz_f,hz_h]=hankel_Gups(w,a,I0,n,econ,H,miu0)
nw=length(w);
Gups_hankel=GupsJ1_140;
n_hankel=140;
s=8.79671439570e-02;
a0=-7.91001919e+00;
hz_f=zeros(nw,1);

for k=1:1:nw
    m=10.^(a0+s*((1:n_hankel)-1))/a;
    [f_hz,f_hh]=hz_kernel(k);%�˺���
    hz_h(k)=f_hh;
    f_hz=f_hz.';
    hz_f(k)=hz_f(k)+Gups_hankel*f_hz;
end

hz_f=hz_f*I0+I0/a/2;
hz_h;

    function  [f_hz,hz_h]=hz_kernel(k)
        [rte,hz_h]=rte_cal(w(k),n,econ,H,m,miu0);
        f_hz=m.*(rte-0.5);
    end


%ϣ�����ص���n_hankel�еķ���ϵ��������
    function  [rte,hz_h]=rte_cal(w,n,cond,H,m,miu0)
        k2=-1i*w*miu0*cond(1:n);  %n������������
        kn2=k2.';   %��Ϊ������
        n_m=length(m);   %�õ�n_hankelֵ
        kn2=repmat(kn2,1,n_m);
        mm=repmat(m,n,1);
        u_d=sqrt(mm.*mm-kn2);  %111111111�˴�������ֻӰ�����������ţ������������Ϊ��������Ƶ����������Ϊ��
        u_up(n,:)=u_d(n,:);
        for j=n-1:-1:1
            u_up(j,:)=u_d(j,:).*(u_up(j+1,:)+u_d(j,:).*((1-exp(-2*u_d(j,:)*H(j)))./(1+exp(-2*u_d(j,:)*H(j)))))./ ...
                (u_d(j,:)+u_up(j+1,:).*((1-exp(-2*u_d(j,:)*H(j)))./(1+exp(-2*u_d(j,:)*H(j)))));
        end
        rte=m./(m+u_up(1,:));
        % ����Ƶ������Ӧ
        kk2=k2(n);
        kk=sqrt(kk2);
        hz_h=-I0*(3-(3+3*1i*kk*a-kk2*a*a)*exp(-1i*kk*a))/(kk2*a*a*a);
    end
end