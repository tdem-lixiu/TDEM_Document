% 该程序是关于qwe算法的，是在kerry key的程序基础上修改得到的
% 时间：2018年11月8日；
% 参考文献：kerry key的《Is the fast Hankel transform faster than quadrature?》
%           weniger的《Nonliner sequence transformations for the acceleration  
%                      of convergence and summation of divergent series》
% 输入变量：func：被积分函数；
%           tol_rel：相对容忍误差；tol_abs：绝对容忍误差；
%           n_max：积分的最大序列数；
% 输出变量：T是结构数组
%           T.extrap是n_max的列向量，记录了每行积分序列中最佳外推数据结果；
%           T.n是一个数，保存该次qwe方法用了n次达到精度要求；
%           T.relErr是n_max的列向量，记录了每行积分序列的绝对误差，T.extrap(n)-T.extrap(n-1)；
%           T.avsErr是n_max的列向量，记录了每行积分序列的相对误差，T.absErr(n)/abs(T.extrap(n))
% 中间变量：T.S是n_max的列向量，记录了0到第n个积分序列的积分和；
% 注意事项：这里的n_max从1开始是S0值，真正0到第一个断点的积分序列是2，即共有n_max个断点(包括零点)；
function T=qwe(func,tol_rel,tol_abs,n_max,varargin)
%
% Then initialize the T structure for the extrapolation results:
%    
    rmin     = realmin;
    
    T.S      = zeros(n_max,1); % working array used for the recursion coefficients for the Epsilon algorithm
    T.extrap = zeros(n_max,1); % extrapolated result for each order of the expansion
    T.relErr = zeros(n_max,1); % relative error for each order
    T.absErr = zeros(n_max,1); % absolute error for each order
    converged= false(1);
    T.S(1)=0;    
%
% The extrapolation transformation loop:
%    
    for i = 2:n_max
        
        f = func(i-1);  
        
        %
        % Step 2: Compute Shanks transformation for each kernel function:
        %
            
        if  converged  
            continue;
        end
                  
        %
        % Insert components into the T structure:
        %
        n        = i;
        T.n      = n;               % order of the expansion
        T.S(n) = T.S(n-1)+f;  % working array for transformation             
        
        %
        % Compute the Shanks transform using the Epsilon algorithm:
        % Structured after Weniger (1989, p26)
        %
        aux2 = 0;
        for k = n:-1:2
            aux1 = aux2;
            aux2 = T.S(k-1);
            ddff = T.S(k) - aux2;
            if abs(ddff) < rmin
                T.S(k-1) = realmax;
            else
                T.S(k-1) = aux1 + 1/ddff;
            end
        end
        
        if (mod(n-1,2)==0)
            T.extrap(n) = T.S(1);
        else
            T.extrap(n) = T.S(2);
        end
        %
        % Step 3: Analyze for convergence:
        %
        if n > 1
            T.absErr(n) = abs( T.extrap(n) - T.extrap(n-1));
            T.relErr(n) = T.absErr(n) / abs(T.extrap(n)) ;
            converged   = T.relErr(n) < tol_rel + tol_abs/abs(T.extrap(n));
        end
        
    
        if converged
            break;
        end
    
    end
    % extrapolation loop


end