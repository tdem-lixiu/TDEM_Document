% 求取的只是随偏移距变换的子程序
% 该处的hz是指频率域的值；
% 输入：同子程序f_qwe；
% 输出：同子程序f_qwe；
% 作用：研究单一变量与频率域响应的关系，这里是偏移距
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