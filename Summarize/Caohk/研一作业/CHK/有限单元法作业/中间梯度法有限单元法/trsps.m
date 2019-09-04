function [ps,x_u]=trsps(U_P,K_mn,x,I0)
n_x=length(x);
x_u=zeros(1,n_x-1);
for i=1:1:n_x-1
    x_u(i)= (x(i+1)+x(i))/2.d0;
    ps(i)=( U_P(i+1)-U_P(i) )/( x(i+1)-x(i) );
end

end