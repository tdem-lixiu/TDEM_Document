% �ó����ǹ���qwe�㷨�ģ�����kerry key�ĳ���������޸ĵõ���
% ʱ�䣺2018��11��8�գ�
% �ο����ף�kerry key�ġ�Is the fast Hankel transform faster than quadrature?��
%           weniger�ġ�Nonliner sequence transformations for the acceleration  
%                      of convergence and summation of divergent series��
% ���������func�������ֺ�����
%           tol_rel�����������tol_abs������������
%           n_max�����ֵ������������
% ���������T�ǽṹ����
%           T.extrap��n_max������������¼��ÿ�л�������������������ݽ����
%           T.n��һ����������ô�qwe��������n�δﵽ����Ҫ��
%           T.relErr��n_max������������¼��ÿ�л������еľ�����T.extrap(n)-T.extrap(n-1)��
%           T.avsErr��n_max������������¼��ÿ�л������е������T.absErr(n)/abs(T.extrap(n))
% �м������T.S��n_max������������¼��0����n���������еĻ��ֺͣ�
% ע����������n_max��1��ʼ��S0ֵ������0����һ���ϵ�Ļ���������2��������n_max���ϵ�(�������)��
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