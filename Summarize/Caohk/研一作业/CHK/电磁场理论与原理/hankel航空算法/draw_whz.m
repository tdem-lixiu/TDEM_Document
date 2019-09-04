% ��ȡ��ֻ����Ƶ�ʱ任(��Ƶ������Ӧ)���ӳ���
% �ô���hz��ָƵ�����ֵ��
% ���룺ͬ�ӳ���f_qwe��
% �����ͬ�ӳ���f_qwe��
% ���ã��о���һ������Ƶ������Ӧ�Ĺ�ϵ��������Ƶ��
function hz=draw_whz(w,r,a,I0,h,z,n,econ,H,miu0)

hz=hankel_Gups(w,r,a,I0,h,z,n,econ,H,miu0);
%%
figure;
subplot(2,1,1);
plot(log10(w),real(hz));
legend('Real Hankel');
xlabel('frequency (Hz)');
ylabel('real(Hz) (T)');

hold on;
subplot(2,1,2)
plot(log10(w),imag(-hz));
legend('imag Hankel');
xlabel('frequency (Hz)');
ylabel('Im(Hz) (T)');

% axis tight;
% set(gca,'ytick',10.^(-16:1:0));
% set(gcf,'paperposition',[2 2 4.3 5]);

%%��������
outfile=strcat(num2str(n),'��','_',num2str(a),'_',num2str(r),'_',date,'f.txt');
fid=fopen(outfile,'wt');
fprintf(fid,'%s%e %s%e','I0=',I0,'r=',r);
fprintf(fid,'\n');
fprintf(fid,'%s','ÿ���ȷֱ�Ϊ��');
for k=1:n
    fprintf(fid,'%e\t',H(k));
end
fprintf(fid,'\n');
fprintf(fid,'%s','ÿ��絼�ʷֱ�Ϊ��');
for k=1:n
    fprintf(fid,'%e\t',econ(k));
end
fprintf(fid,'\n');
fprintf(fid,'%s\n','�������ݣ�');
nt=length(w);
for k=1:nt
    fprintf(fid,'%e  %e  %e',w(k),real(hz(k)),imag(hz(k)));
    fprintf(fid,'\n');
end
fclose(fid);

end