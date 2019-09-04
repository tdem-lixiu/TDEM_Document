% 理论解
function bz_t=analysis(econ,a,I0,miu0,t)
% econ=0.001;
% a=2;  %5;
% I0=1;
% miu0=4.d-7*pi;
% t=tsamp(1.d-4,1.d2,61);
temp=sqrt(1.d7*pi*2.d0/econ*t);
u=2.d0*pi*a./temp;
hz_t=(3.d0*I0/econ/a/a/a/miu0)*( erf((u)/sqrt(2))-sqrt(2.d0/pi)*u.*(1.d0+u.*u/3).*exp(-1.d0*u.*u/2.d0) );
bz_t=hz_t*miu0;
plot(log10(t),log10(bz_t))
nt=length(t);
%%
% 画图
outfile=strcat('analysis',date,'.txt');
fid=fopen(outfile,'wt');
fprintf(fid,'%e\t',econ);
fprintf(fid,'\n');
fprintf(fid,'%s\n','正演数据：');
for k=1:nt
    fprintf(fid,'%e  %e',t(k),bz_t(k));
    fprintf(fid,'\n');
end
fclose(fid);
end
