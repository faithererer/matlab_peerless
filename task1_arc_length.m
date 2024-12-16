% Task 1: Write a MATLAB function that uses Adaptive Quadrature to compute 
% the arc length from t=0 to t=T for a given T≤1
% 题目1：编写一个MATLAB函数，使用自适应求积法计算从t=0到t=T的弧长(T≤1)

function length = task1_arc_length(T)
    % 使用自适应Simpson求积法计算弧长
    tol = 1e-8;  % 误差容限
    
    % 初始划分
    n = 10;  % 初始区间数
    t = linspace(0, T, n+1);
    h = T/n;
    
    % 计算函数值
    y = integrand(t);
    
    % Simpson求积
    length = h/3 * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) + y(end));
    
    % 自适应加密
    while n < 1000  % 设置最大区间数防止无限循环
        n_new = 2*n;
        t_new = linspace(0, T, n_new+1);
        h_new = T/n_new;
        
        y_new = integrand(t_new);
        length_new = h_new/3 * (y_new(1) + 4*sum(y_new(2:2:end-1)) + 2*sum(y_new(3:2:end-2)) + y_new(end));
        
        % 检查收敛
        if abs(length_new - length) < tol * abs(length_new)
            length = length_new;
            return;
        end
        
        n = n_new;
        length = length_new;
    end
end

function y = integrand(t)
    % 计算被积函数：sqrt(x'(t)^2 + y'(t)^2)
    
    % 计算x'(t)和y'(t)
    dxdt = 0.3 + 2*3.9*t - 3*4.7*t.^2;
    dydt = 0.3 + 2*0.9*t - 3*2.7*t.^2;
    
    % 计算弧长微元
    y = sqrt(dxdt.^2 + dydt.^2);
end