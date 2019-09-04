function K=Inside1(I,I_cond,a,b)
K=zeros(4,4,I);
alph=I_cond.*b/6./a;
beta=I_cond.*a/6./b;
K(1,1,:)=2*alph+2*beta;
K(2,1,:)=alph-2*beta;
K(3,1,:)=-alph-beta;
K(4,1,:)=-2*alph+beta;
K(2,2,:)=K(1,1,:);
K(3,2,:)=K(4,1,:);
K(4,2,:)=K(3,1,:);
K(3,3,:)=K(1,1,:);
K(4,3,:)=K(2,1,:);
K(4,4,:)=K(1,1,:);
for i=1:1:I
    K(:,:,i)=K(:,:,i)+triu(K(:,:,i).',1); %ππΩ®∂‘≥∆æÿ’Û  
end
end