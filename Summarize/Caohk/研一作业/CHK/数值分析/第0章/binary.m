%binary 是关于二进制和十进制互相转换的程序
% 输入：a代表输入转换的方向：
%       其中0代表十进制转换为二进制，1代表二进制代表二进制转换为十进制，
%       k代表输入数
%       b代表整数部分，
%       c代表小数部分。
% 输出：转换结果d
% 存在明显的精度问题，在进行浮点运算时如若使用了类似floor的函数时应尽量加上一个极小值！
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
        while (b/10)>0.000001      %大于0
            i=i+1;
            k0(i)=mod(b,10);
            b=floor(b/10);
        end 
        while c>0.0000001      %大于0
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


        
        
        