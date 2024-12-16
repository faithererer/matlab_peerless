% Task 4: Replace the Bisection Method with Newton's Method
% 题目4：用牛顿法替代二分法，重复第2和第3题的计算

function t_star = task4_newton_method(s)
    % 计算总弧长
    total_length = task1_arc_length(1);
    target_length = s * total_length;
    
    % 牛顿法参数
    tol = 1e-3;
    max_iter = 100;
    t = s;  % 使用s作为初始猜测值
    
    for i = 1:max_iter
        % 计算函数值和导数
        current_length = task1_arc_length(t);
        f = current_length - target_length;
        
        % 计算导数（直接计算速度，而不是通过弧长差分）
        dxdt = 0.3 + 2*3.9*t - 3*4.7*t^2;
        dydt = 0.3 + 2*0.9*t - 3*2.7*t^2;
        df = sqrt(dxdt^2 + dydt^2);
        
        % 牛顿迭代
        t_new = t - f/df;
        
        % 检查收敛
        if abs(t_new - t) < tol
            t_star = t_new;
            return;
        end
        t = t_new;
    end
    t_star = t;
end 