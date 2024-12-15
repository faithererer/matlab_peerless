% Task 1: Write a MATLAB function that uses Adaptive Quadrature to compute 
% the arc length from t=0 to t=T for a given T≤1
% 题目1：编写一个MATLAB函数，使用自适应求积法计算从t=0到t=T的弧长(T≤1)

function length = task1_arc_length(T)
    % 使用自适应Simpson求积法计算弧长
    tol = 1e-8;  % 误差容限
    length = adaptive_quad(@integrand, 0, T, tol);
end

function y = integrand(t)
    % 计算被积函数：sqrt(x'(t)^2 + y'(t)^2)
    
    % 计算x'(t)和y'(t)
    dxdt = 0.3 + 2*3.9*t - 3*4.7*t.^2;
    dydt = 0.3 + 2*0.9*t - 3*2.7*t.^2;
    
    % 计算弧长微元
    y = sqrt(dxdt.^2 + dydt.^2);
end

function integral = adaptive_quad(f, a, b, tol)
    % 自适应Simpson求积法
    c = (a + b)/2;
    h = (b - a)/2;
    
    % 计算Simpson积分近似值
    fa = f(a);
    fb = f(b);
    fc = f(c);
    
    S = h*(fa + 4*fc + fb)/3;
    
    % 递归计算，直到达到精度要求
    integral = adaptive_quad_recursive(f, a, b, tol, S, fa, fc, fb);
end

function integral = adaptive_quad_recursive(f, a, b, tol, S, fa, fc, fb)
    % 递归实现自适应Simpson求积
    h = (b - a)/2;
    c = (a + b)/2;
    
    % 计算两个子区间的中点
    d = (a + c)/2;
    e = (c + b)/2;
    
    fd = f(d);
    fe = f(e);
    
    % 计算左右子区间的Simpson积分
    S1 = h*(fa + 4*fd + fc)/6;
    S2 = h*(fc + 4*fe + fb)/6;
    
    % 比较精度（相对误差）
    if abs(S1 + S2 - S) < tol * abs(S1 + S2)
        integral = S1 + S2;
    else
        % 递归细分区间
        integral = adaptive_quad_recursive(f, a, c, tol/2, S1, fa, fd, fc) + ...
                  adaptive_quad_recursive(f, c, b, tol/2, S2, fc, fe, fb);
    end
end