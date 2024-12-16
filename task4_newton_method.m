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

function v = velocity(t)
    % 计算参数曲线在t处的速度
    dxdt = 0.3 + 2*3.9*t - 3*4.7*t.^2;
    dydt = 0.3 + 2*0.9*t - 3*2.7*t.^2;
    v = dxdt.^2 + dydt.^2;
end

% 使用牛顿法的等分函数
function task4_equipartition(n)
    % 计算等分点
    s_values = linspace(0, 1, n+1); % 生成从 0 到 1 的n+1 个均匀分布的 s 值
    t_values = zeros(size(s_values)); % 初始化 t_values 为零
    
    % 对每个s计算对应的t值，使用牛顿法
    for i = 1:length(s_values)
        t_values(i) = task4_newton_method(s_values(i));
    end
    
    % 绘制路径和等分点
    t_plot = linspace(0, 1, 100);
    x_plot = 0.5 + 0.3*t_plot + 3.9*t_plot.^2 - 4.7*t_plot.^3;
    y_plot = 1.5 + 0.3*t_plot + 0.9*t_plot.^2 - 2.7*t_plot.^3;
    
    % 计算等分点的坐标
    x_points = 0.5 + 0.3*t_values + 3.9*t_values.^2 - 4.7*t_values.^3;
    y_points = 1.5 + 0.3*t_values + 0.9*t_values.^2 - 2.7*t_values.^3;
    
    % 绘图
    figure;
    plot(x_plot, y_plot, 'b-', 'LineWidth', 1);
    hold on;
    plot(x_points, y_points, 'ro', 'MarkerSize', 8);
    grid on;
    title(['Path Equipartitioned using Newton''s Method (' num2str(n) ' segments)']);
    xlabel('x');
    ylabel('y');
end 