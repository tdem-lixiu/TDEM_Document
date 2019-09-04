% 求取的只是随偏移距变换的子程序
% 该处的hz是指频率域的值；
% 输入：同子程序f_qwe；
% 输出：同子程序f_qwe；
% 作用：研究单一变量与频率域响应的关系，这里是偏移距
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