function P=Bound(I,I_cond,a,b,I_left,I_right,E0)
P=zeros(4,I);  %第二个下标代表第i个单元的P向量
% 给出边界start
P(1,I_left(1:end))=1;
P(2,I_left(1:end))=1;
P(3,I_right(1:end))=-1;
P(4,I_right(1:end))=-1;
% 给出边界end
for i=1:1:I
    P(:,i)=P(:,i)*I_cond(i)*b(i)/2;
end
end