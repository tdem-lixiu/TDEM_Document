% 理论解
function [dbzdt_t,bz_t]=analysis(econ,a,I0,miu0,t,component)
dbzdt_t=0;
bz_t=0;
if component==1
    temp=sqrt(1.d7*pi*2.d0/econ*t);
    u=2.d0*pi*a./temp;
    dhzdt_t=(3.d0*I0/econ/a/a/a/miu0)*( erf((u)/sqrt(2))-sqrt(2.d0/pi)*u.*(1.d0+u.*u/3).*exp(-1.d0*u.*u/2.d0) );
    dbzdt_t=dhzdt_t*miu0;
    %%
    % 写入数据
    nt=length(t);
    outfile=strcat('analysis',date,'.txt');
    fid=fopen(outfile,'wt');
    fprintf(fid,'%e\t',econ);
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','正演数据：');
    for k=1:nt
        fprintf(fid,'%e  %e',t(k),dbzdt_t(k));
        fprintf(fid,'\n');
    end
    fclose(fid);
%%
elseif component==2
    temp=sqrt(1.d7*pi/econ*t);
    u=pi*a./temp;
    hz_t=(I0/2.d0/a).*( 3.d0./(sqrt(pi).*u).*exp(-u.*u)+(1-1.5d0./u./u).*erf(u) );
    bz_t=hz_t*miu0;
    %%
    % 写入数据
    nt=length(t);
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
elseif component==0
    temp=sqrt(1.d7*pi*2.d0/econ*t);
    u=2.d0*pi*a./temp;
    dhzdt_t=(3.d0*I0/econ/a/a/a/miu0)*( erf((u)/sqrt(2))-sqrt(2.d0/pi)*u.*(1.d0+u.*u/3).*exp(-1.d0*u.*u/2.d0) );
    dbzdt_t=dhzdt_t*miu0;
    
    
    temp=sqrt(1.d7*pi/econ*t);
    u=pi*a./temp;
    hz_t=(I0/2.d0/a).*( 3.d0./(sqrt(pi).*u).*exp(-u.*u)+(1-1.5d0./u./u).*erf(u) );
    bz_t=hz_t*miu0;

    %%
    % 写入数据
    nt=length(t);
    outfile=strcat('analysis',date,'.txt');
    fid=fopen(outfile,'wt');
    fprintf(fid,'%e\t',econ);
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','正演数据：');
    fprintf(fid,'%s    %s    %s\n','时间','Bz','dBz/dt');
    for k=1:nt
        fprintf(fid,'%e  %e  %e',t(k),bz_t(k),dbzdt_t(k));
        fprintf(fid,'\n');
    end
    fclose(fid);
end
end
