% 参考文献：《New digital linear filters for Hankel J0 and J1 transforms》
% 调用滤波系数
% 本程序是关于J0的61位滤波系数
% 相关参数：a=-5.0825e+00,s=1.16638303862e-01;
% 输出：行向量的滤波系数矩阵
function [Gups,a,s]=GupsJ0_61
Gups=[3.30220475766e-04 -1.18223623458e-03  2.01879495264e-03 -2.13218719891e-03 ...
      1.60839063172e-03 -9.09156346708e-04  4.37889252738e-04 -1.55298878782e-04 ...
      7.98411962729e-05  4.37268394072e-06  3.94253441247e-05  4.02675924344e-05 ...
      5.66053344653e-05  7.25774926389e-05  9.55412535465e-05  1.24699163157e-04 ...
      1.63262166579e-04  2.13477133718e-04  2.79304232173e-04  3.65312787897e-04 ...
      4.77899413107e-04  6.25100170825e-04  8.17726956451e-04  1.06961339341e-03 ...
      1.39920928148e-03  1.83020380399e-03  2.39417015791e-03  3.13158560774e-03 ...
      4.09654426763e-03  5.35807925630e-03  7.00889482693e-03  9.16637526490e-03 ...
      1.19891721272e-02  1.56755740646e-02  2.04953856060e-02  2.67778388247e-02 ...
      3.49719672729e-02  4.55975312615e-02  5.93498881451e-02  7.69179091244e-02 ...
      9.91094769804e-02  1.26166963993e-01  1.57616825575e-01  1.89707800260e-01 ...
      2.13804195282e-01  2.08669340316e-01  1.40250562745e-01 -3.65385242807e-02 ...
     -2.98004010732e-01 -4.21898149249e-01  5.94373771266e-02  5.29621428353e-01 ...
     -4.41362405166e-01  1.90355040550e-01 -6.19966386785e-02  1.87255115744e-02 ...
     -5.68736766738e-03  1.68263510609e-03 -4.38587145792e-04  8.59117336292e-05 ...
     -9.15853765160e-06];
 a=-5.0825e+00;
 s=1.16638303862e-01;
end