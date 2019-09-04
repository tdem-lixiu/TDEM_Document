% ��ȡ��ֻ����ƫ�ƾ�任���ӳ���
% �ô���hz��ָƵ�����ֵ��
% ���룺ͬ�ӳ���f_qwe��
% �����ͬ�ӳ���f_qwe��
% ���ã��о���һ������Ƶ������Ӧ�Ĺ�ϵ��������ƫ�ƾ�
function hz=draw_rhz(w,r,a,I0,h,z,n,econ,H,miu0)

hz=hankel_Gups(w,r,a,I0,h,z,n,econ,H,miu0);
%%
figure;
hh=semilogy(r,abs(real(hz)),'k-', ...
     r,abs(imag(hz)),'ko');
legend('Real Hankel','Imag Hankel');
xlabel('Range(m)');
ylabel('Hz(T)');
title('Hankel for AEM');
axis tight;
set(gca,'xtick',0.2*a*(0:1:10));
set(gca,'ytick',10.^(-16:1:0));
set(gcf,'paperposition',[2 2 4.3 5]);
end