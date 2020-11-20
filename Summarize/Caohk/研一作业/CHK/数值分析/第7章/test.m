clear;
clc;
x0=[0;0;0];
k=150;
x=broyden2(@ringd,x0,k)
