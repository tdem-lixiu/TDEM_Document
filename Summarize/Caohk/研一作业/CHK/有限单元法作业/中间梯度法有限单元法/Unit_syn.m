% 合成的思路：
% 将每个单元的矩阵和向量先拆解为方程组，再将所有的方程组组合起来
% 最后进行单元的合成就能变为一个大的矩阵
% 这里的细节是：将边界处耦合起来，其实就是将边界处不同单元的几个方程加起来变为一个                                                                                         
function Ke=Unit_syn(K1,K2,K3,I,I_point)
n_point=I_point(3,end);  %提取总节点数
Ke=zeros(n_point,n_point);
for i=1:1:I
   I1=I_point(1,i);
   I2=I_point(2,i);
   I3=I_point(3,i);
   I4=I_point(4,i);
   Ke(I1,[I1,I2,I3,I4])=Ke(I1,[I1,I2,I3,I4])+K1(1,:,i)+K2(1,:,i)+K3(1,:,i);
   Ke(I2,[I1,I2,I3,I4])=Ke(I2,[I1,I2,I3,I4])+K1(2,:,i)+K2(2,:,i)+K3(2,:,i);
   Ke(I3,[I1,I2,I3,I4])=Ke(I3,[I1,I2,I3,I4])+K1(3,:,i)+K2(3,:,i)+K3(3,:,i);
   Ke(I4,[I1,I2,I3,I4])=Ke(I4,[I1,I2,I3,I4])+K1(4,:,i)+K2(4,:,i)+K3(4,:,i);
end
    



end