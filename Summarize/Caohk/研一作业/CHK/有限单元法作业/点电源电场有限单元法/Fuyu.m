% ���ӳ����Ǹ�ÿһ����Ԫ����絼��
% ���õ��Ǹ��Ƿ������Ӵ�Сһ��㸲�Ǹ�ֵ
function I_cond=Fuyu(cond1,cond2,I_normal,I)
I_cond=zeros(1,I);
I_cond(1:end)=cond1;
n_normal=length(I_normal);
for k=1:1:n_normal
    I_cond(1,I_normal(k))=cond2;
end
end