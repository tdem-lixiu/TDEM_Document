clc;
clear;
close all;
n=100000;
m=10; %广告数量
age=rand(n,1);
sex=rand(n,1)>0.5; %0代表男性，1代表为女性
sex=real(sex);
pi=[0.13043 0.23913 0.56522 1.0];
adv=rand(n,m)>0.5;
adv=real(adv);
A=zeros(n,m);
for i=1:1:n
    if age(i)<pi(1)
        H=[0.7;0.1;0.1;0.1;0.7;0.4;0.1;0.7;1.0;0.1];
    elseif age(i)<pi(2)
        if sex(i)>0
            H=[0.7;0.4;0.7;0.7;1.0;0.7;0.4;1.0;0.7;1.0];
        else
            H=[1.0;0.1;0.7;0.1;0.7;0.7;0.1;0.1;0.7;0.4];
        end
    elseif age(i)<pi(3)
        if sex(i)>0
            H=[0.7;0.4;0.7;0.7;1.0;0.7;0.4;1.0;0.7;1.0];
        else
            H=[0.7;0.7;1.0;1.0;0.4;0.7;1.0;0.1;0.4;0.7];
        end
    else
        H=[0.1;1.0;0.1;0.7;0.1;0.1;0.4;0.4;0.1;0.1];
    end
    H=real(H>rand(10,1));
    A(i,:)= (adv(i,:) .* (H).');
end
result=[age sex adv A];
save data2 result
            