% ���ӳ����Ǹ�ÿһ����Ԫ����絼��
% ���õ��Ǹ��Ƿ������Ӵ�Сһ��㸲�Ǹ�ֵ
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