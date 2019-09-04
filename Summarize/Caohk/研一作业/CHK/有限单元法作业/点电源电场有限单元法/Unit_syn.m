% 合成的思路：
% 将每个单元的矩阵和向量先拆解为方程组，再将所有的方程组组合起来
% 最后进行单元的合成就能变为一个大的矩阵
% 这里的细节是：将边界处耦合起来，其实就是将边界处不同单元的几个方程加起来变为一个                                                                                         
function [Ke,Pe]=Unit_syn(K,P,I,I_point)
n_point=I_point(3,end);  %提取总节点数
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