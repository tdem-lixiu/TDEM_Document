% hz_f��nw��nr�еľ��󣬼���ͬ���д���ͬ��Ƶ����Ӧ������ͬ���д���ͬ��λ����Ӧ
% ���룺w����������r��������
function hz_f=hankel_Gups(w,a,I0,n,econ,H,miu0)
nw=length(w);
Gups_hankel=GupsJ1_140;
n_hankel=140;
s=8.79671439570e-02;
a0=-7.91001919e+00;
hz_f=zeros(nw,1);    

for k=1:1:nw
    m=10.^(a0+s*((1:n_hankel)-1))/a;
    f_hz=hz_kernel(k);    %�˺���
    f_hz=f_hz.';
    hz_f(k)=hz_f(k)+Gups_hankel*f_hz;
end

hz_f=hz_f*I0+I0/a/2;

    function  f_hz=hz_kernel(k)
        rte=rte_cal(w(k),n,econ,H,m,miu0);
        f_hz=m.*(rte-0.5);
    end


%ϣ�����ص���n_hankel�еķ���ϵ��������
    function  rte=rte_cal(w,n,cond,H,m,miu0)
        k2=-1i*w*miu0*cond(1:n);  %n������������
        kn2=k2.';   %��Ϊ������
        n_m=length(m);   %�õ�n_hankelֵ
        kn2=repmat(kn2,1,n_m);
        mm=repmat(m,n,1);
        u_d=sqrt(mm.*mm-kn2);  %111111111
        u_up(n,:)=u_d(n,:);
        for j=n-1:-1:1
            u_up(j,:)=u_d(j,:).*(u_up(j+1,:)+u_d(j,:).*((1-exp(-2*u_d(j,:)*H(j)))./(1+exp(-2*u_d(j,:)*H(j)))))./ ...
                (u_d(j,:)+u_up(j+1,:).*((1-exp(-2*u_d(j,:)*H(j)))./(1+exp(-2*u_d(j,:)*H(j)))));
        end
        rte=m./(m+u_up(1,:));
    end
end