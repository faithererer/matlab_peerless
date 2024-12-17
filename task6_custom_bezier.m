% Task 6: Create and equipartition a custom Bezier curve path
% 题目6：创建自定义贝塞尔曲线路径并进行等分

function task6_custom_bezier
    % 定义控制点（创建一个"S"形状）
    control_points = [
        0, 0;    % P0
        1, 2;    % P1
        2, -1;   % P2
        3, 1     % P3
    ];
    
    % 设置图形窗口
    set(gca, 'XLim', [-0.5 3.5], 'YLim', [-1.5 2.5], ...
        'Drawmode', 'fast', 'Visible', 'on');
    cla
    axis square
    grid on;
    hold on;
    
    % 绘制控制多边形
    plot(control_points(:,1), control_points(:,2), 'k--o');
    
    % 绘制贝塞尔曲线
    t_plot = linspace(0, 1, 100);
    [x_plot, y_plot] = bezier_curve(t_plot, control_points);
    plot(x_plot, y_plot, 'b-', 'LineWidth', 1);
    
    % 等分曲线
    n = 20;  % 分段数
    s_values = linspace(0, 1, n+1);
    t_values = zeros(size(s_values));
    
    % 计算等分点
    for i = 1:length(s_values)
        t_values(i) = find_t_newton(s_values(i), control_points);
    end
    
    % 计算等分点的坐标
    [x_points, y_points] = bezier_curve(t_values, control_points);
    plot(x_points, y_points, 'ro', 'MarkerSize', 8);
    title('Custom Bezier Curve with Equal Arc Length Partitions');
    
    % 创建运动点
    ball = plot(x_plot(1), y_plot(1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    
    % 等速运动演示
    title('Motion with Constant Speed on Bezier Curve');
    for s = linspace(0, 1, 50)
        t = find_t_newton(s, control_points);
        [x, y] = bezier_curve(t, control_points);
        
        % 使用题目要求的命令更新位置
        set(ball, 'xdata', x, 'ydata', y);
        drawnow;
        pause(0.05);
    end
end

function [x, y] = bezier_curve(t, control_points)
    % 确保t是列向量
    t = t(:);
    % 三次贝塞尔曲线公式
    B = [(1-t).^3, 3*t.*(1-t).^2, 3*t.^2.*(1-t), t.^3];
    x = B * control_points(:,1);
    y = B * control_points(:,2);
end

function t = find_t_newton(s, control_points)
    % 使用牛顿法找到对应的参数t
    t = s;  % 初始猜测
    tol = 1e-6;
    max_iter = 50;
    total_length = compute_arc_length(1, control_points);
    
    for i = 1:max_iter
        current_length = compute_arc_length(t, control_points);
        [dx, dy] = bezier_derivative(t, control_points);
        
        % 计算函数值和导数
        f = current_length/total_length - s;
        df = sqrt(dx^2 + dy^2)/total_length;
        
        % 牛顿迭代
        t_new = t - f/df;
        
        % 确保t_new在[0,1]范围内
        t_new = max(0, min(1, t_new));
        
        % 检查收敛
        if abs(t_new - t) < tol
            t = t_new;
            return;
        end
        t = t_new;
    end
end

function [dx, dy] = bezier_derivative(t, control_points)
    % 计算贝塞尔曲线的导数
    t = t(:);  % 确保t是列向量
    
    % 计算导数的基函数
    dB = [-3*(1-t).^2, 3*(1-4*t+3*t.^2), 3*(2*t-3*t.^2), 3*t.^2];
    
    % 计算x和y方向的导数
    dx = dB * control_points(:,1);
    dy = dB * control_points(:,2);
end

function len = compute_arc_length(t_end, control_points)
    % 使用复合Simpson求积计算弧长
    n = 100;  % 积分区间数
    t = linspace(0, t_end, n+1);
    h = t_end/n;
    
    % 计算所有点的速度
    [dx, dy] = bezier_derivative(t, control_points);
    v = sqrt(dx.^2 + dy.^2);
    
    % Simpson求积
    len = h/3 * (v(1) + 4*sum(v(2:2:end-1)) + 2*sum(v(3:2:end-2)) + v(end));
end