% 此子程序是给每一个单元赋予电导率
% 采用的是覆盖方法，从大到小一层层覆盖赋值
function I_cond=Fuyu(cond1,cond2,I_normal,I)
I_cond=zeros(1,I);
I_cond(1:end)=cond1;
n_normal=length(I_normal);
for k=1:1:n_normal
    I_cond(1,I_normal(k))=cond2;
end
end