function [I,I_point,I_xy]=Poufen(x,y)
n_x=length(x);
n_y=length(y);
I=(n_x-1)*(n_y-1);
I_point=zeros(4,I);
I_xy=zeros(2,n_x*n_y);
for i=1:1:n_x-1
    I_point(1,(i-1)*(n_y-1)+1:i*(n_y-1)) = (1+(i-1)*n_y:i*n_y-1);   %I_point(m,n),m代表节点编号，n代表单元号
    I_point(2,(i-1)*(n_y-1)+1:i*(n_y-1)) = (2+(i-1)*n_y:i*n_y);      %m是4，n等于单元总数,这步时给每个单元的节点编号
    I_point(4,(i-1)*(n_y-1)+1:i*(n_y-1)) = (1+i*n_y:(i+1)*n_y-1);
    I_point(3,(i-1)*(n_y-1)+1:i*(n_y-1)) = (2+i*n_y:(i+1)*n_y);
end

% 给每个编号节点赋值坐标I_xy(m,n)，m是2，代表维数，n代表节点编号
for i=1:1:n_x
   I_xy(1,(i-1)*n_y+1:i*n_y) = x(i);
   I_xy(2,(i-1)*n_y+1:i*n_y) = y(1:n_y);
end


end