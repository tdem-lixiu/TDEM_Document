%binary �ǹ��ڶ����ƺ�ʮ���ƻ���ת���ĳ���
% ���룺a��������ת���ķ���
%       ����0����ʮ����ת��Ϊ�����ƣ�1��������ƴ��������ת��Ϊʮ���ƣ�
%       k����������
%       b�����������֣�
%       c����С�����֡�
% �����ת�����d
% �������Եľ������⣬�ڽ��и�������ʱ����ʹ��������floor�ĺ���ʱӦ��������һ����Сֵ��
function d=binary(a,k)
i=0;
j=0;
d=0;
b=floor(k);
c=k-b;
if a==0
    while b>0.000001
        i=i+1;
        k0(i)=mod(b,2);
        b=floor(b/2);
    end 
    while c*2-floor(c*2+0.0000001)>0 || j<20
        j=j+1;
        k1(j)=floor(c*2);
        c=c*2-k1(j);
    end
    for ii=1:1:i
        d=k0(ii)*10^(ii-1)+d;
    end
    for ii=1:1:j
        d=d+k1(ii)*10^(-ii);
    end
else if a==1
        while (b/10)>0.000001      %����0
            i=i+1;
            k0(i)=mod(b,10);
            b=floor(b/10);
        end 
        while c>0.0000001      %����0
            j=j+1;
            k1(j)=floor(c*10+0.0000001);           
            c=c*10-k1(j);
        end 
        for ii=1:1:i
            d=k0(ii)*2^(ii-1)+d;
        end
        for ii=1:1:j
            d=k1(ii)*0.5^(ii)+d;
        end
    end
end


        
        
        