% 求取的只是随频率变换(即频率域响应)的子程序，
% 该处的hz是指频率域的值；
% 输入：同子程序f_qwe；
% 输出：同子程序f_qwe；
% 作用：研究单一变量与频率域响应的关系，这里是频率
function hz=draw_whz(n_gauss,n_qmax,nu,w,n,econ,H,miu0,I0,a,r,z,h,relTol,absTol)

hz=f_qwe(n_gauss,n_qmax,nu,w,n,econ,H,miu0,I0,a,r,z,h,relTol,absTol);
%%
figure;
subplot(2,1,1);
plot(log10(w),real(hz));
legend('Real QWE');
xlabel('frequency (Hz)');
ylabel('real(Hz) (T)');

hold on;
subplot(2,1,2)
plot(log10(w),imag(hz));
legend('imag QWE');
xlabel('frequency (Hz)');
ylabel('Im(Hz) (T)');

% axis tight;
% set(gca,'ytick',10.^(-16:1:0));
% set(gcf,'paperposition',[2 2 4.3 5]);

%%保存数据
outfile=strcat(num2str(n),'层','_',num2str(a),'_',num2str(r),'_',date,'f.txt');
fid=fopen(outfile,'wt');
fprintf(fid,'%s%e %s%e','I0=',I0,'r=',r);
fprintf(fid,'\n');
fprintf(fid,'%s','每层厚度分别为：');
for k=1:n
    fprintf(fid,'%e\t',H(k));
end
fprintf(fid,'\n');
fprintf(fid,'%s','每层电导率分别为：');
for k=1:n
    fprintf(fid,'%e\t',econ(k));
end
fprintf(fid,'\n');
fprintf(fid,'%s\n','正演数据：');
nt=length(w);
for k=1:nt
    fprintf(fid,'%e  %e  %e',w(k),real(hz(k)),imag(hz(k)));
    fprintf(fid,'\n');
end
fclose(fid);

end