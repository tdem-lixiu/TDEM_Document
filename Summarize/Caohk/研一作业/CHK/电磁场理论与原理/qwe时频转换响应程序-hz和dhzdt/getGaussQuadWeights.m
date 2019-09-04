%------------------------------------------------------------------%
% Copyright (c) 2012 by the Society of Exploration Geophysicists.  %
% For more information, go to http://software.seg.org/2012/0003 .  %
% You must read and accept usage terms at:                         %
% http://software.seg.org/disclaimer.txt before use.               %
%------------------------------------------------------------------%

%--------------------------------------------------------------------------
function [x,w] = getGaussQuadWeights(N)
%
% Returns Gauss quadrature weights of order N on the interval -1,1
%
% Algorithm from p 129 in:
% Trefethen, L. N., 2000, Spectral methods in MATLAB: Society for 
% Industrial and Applied Mathematics (SIAM), volume 10 of Software, 
% Environments, and Tools.
%   
%--------------------------------------------------------------------------
% 输出量x,w都为列向量
    beta  = 0.5./sqrt(1-(2*(1:N-1)).^(-2));
    T     = diag(beta,1) + diag(beta,-1);
    [V,D] = eig(T);
    [x,i] = sort(diag(D));
    w     = 2*V(1,i)'.^2;
    
    
end
