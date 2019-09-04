% hz_f��nw��nr�еľ��󣬼���ͬ���д���ͬ��Ƶ����Ӧ������ͬ���д���ͬ��λ����Ӧ
% ���룺w����������r��������
function [hz_f,hz_h]=hankel_Gups(w,r,a,I0,h,z,n,econ,H,miu0)
nw=length(w);
nr=length(r);
[Gups_hankel,a0,s]=GupsJ1_140;
n_hankel=140;
hz_f=zeros(nw,nr);
for ir=1:1:nr
    m=(10.^(a0+s*((1:n_hankel)-1)))/a;  %��n_hankel�е������� 1
    for k=1:1:nw    
        f_hz=hz_kernel(k);    %�˺���
        f_hz=f_hz.';
        hz_f(k,ir)=hz_f(k,ir)+Gups_hankel*f_hz;
    end
    hz_f(:,ir)=hz_f(:,ir)*I0/2;
end

    function  [f_hz,hz_h]=hz_kernel(k)
        [rte,hz_h]=rte_cal(w(k),n,econ,H,m,miu0);
        a1=exp(-m*abs(h+z));
        a2=rte.*exp(m*(z-h));
        f_hz=(a1+a2).*m.*besselj(0,m*r(ir));
    end


%ϣ�����ص���n_hankel�еķ���ϵ��������
    function  [rte,hz_h]=rte_cal(w,n,cond,H,m,miu0)
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
        % ����Ƶ������Ӧ
        kk2=k2(n);
        kk=sqrt(kk2);
        hz_h=-I0*(3-(3+3*1i*kk*a-kk2*a*a)*exp(-1i*kk*a))/(kk2*a*a*a);
        rte=(m-u_up(1,:))./(m+u_up(1,:));
    end
end