% ��ȡ��ֻ����ƫ�ƾ�任���ӳ���
% �ô���hz��ָƵ�����ֵ��
% ���룺ͬ�ӳ���f_qwe��
% �����ͬ�ӳ���f_qwe��
% ���ã��о���һ������Ƶ������Ӧ�Ĺ�ϵ��������ƫ�ƾ�
function hz=draw_rhz(n_gauss,n_qmax,nu,w,n,econ,H,miu0,I0,a,r,z,h,relTol,absTol)

hz=f_qwe(n_gauss,n_qmax,nu,w,n,econ,H,miu0,I0,a,r,z,h,relTol,absTol);
%%
figure;
hh=semilogy(r,abs(real(hz)),'k-',...
    r,abs(imag(hz)),'ko');
legend('Real QWE','Imag QWE');
xlabel('Range(m)');
ylabel('Bz(T)');
title('QWE for loop source');
axis tight;
set(gca,'ytick',10.^(-16:1:0));
set(gcf,'paperposition',[2 2 4.3 5]);
end