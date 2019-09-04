function K=Inside2(I,I_cond,a,b,k)
K=zeros(4,4,I);
alph=a.*b.*k.*k.*I_cond/36;
K(1,1,:)=4*alph;
K(2,1,:)=alph*2;
K(3,1,:)=alph;
K(4,1,:)=2*alph;
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