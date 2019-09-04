% �ϳɵ�˼·��
% ��ÿ����Ԫ�ľ���������Ȳ��Ϊ�����飬�ٽ����еķ������������
% �����е�Ԫ�ĺϳɾ��ܱ�Ϊһ����ľ���
% �����ϸ���ǣ����߽紦�����������ʵ���ǽ��߽紦��ͬ��Ԫ�ļ������̼�������Ϊһ��                                                                                         
function [Ke,Pe]=Unit_syn(K,P,I,I_point)
n_point=I_point(3,end);  %��ȡ�ܽڵ���
Pe=zeros(n_point,1);
Ke=zeros(n_point,n_point);
for i=1:1:I
   I1=I_point(1,i);
   I2=I_point(2,i);
   I3=I_point(3,i);
   I4=I_point(4,i);
   Ke(I1,[I1,I2,I3,I4])=Ke(I1,[I1,I2,I3,I4])+K(1,:,i);
   Ke(I2,[I1,I2,I3,I4])=Ke(I2,[I1,I2,I3,I4])+K(2,:,i);
   Ke(I3,[I1,I2,I3,I4])=Ke(I3,[I1,I2,I3,I4])+K(3,:,i);
   Ke(I4,[I1,I2,I3,I4])=Ke(I4,[I1,I2,I3,I4])+K(4,:,i);
   Pe([I1,I2,I3,I4])=Pe([I1,I2,I3,I4])+P(:,i);
end
end