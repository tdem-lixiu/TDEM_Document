% 此子程序是给每一个单元赋予电导率
% 采用的是覆盖方法，从大到小一层层覆盖赋值
function I_cond=Fuyu(cond,I_normal,I)
I_cond=zeros(1,I);
I_cond(1:end)=cond(1);
n_cond=length(cond);
for i=2:1:n_cond
    n_normal=length(I_normal(i-1,:));
    for k=1:1:n_normal
        I_cond(1,I_normal(k))=cond(i);
    end
end
end