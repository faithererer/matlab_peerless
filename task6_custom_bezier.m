% Task 6: Create and equipartition a custom Bezier curve path
% 题目6：创建自定义贝塞尔曲线路径并进行等分

function task6_custom_bezier
    % 定义控制点（这里创建一个 "S" 形状）
    control_points = [
        0, 0;    % P0
        1, 2;    % P1
        2, -1;   % P2
        3, 1     % P3
    ];

    % 等分曲线
    n = 20;  % 分段数
    s_values = linspace(0, 1, n+1);
    t_values = zeros(size(s_values));
    total_length = compute_arc_length(1, control_points);

    % 使用牛顿法找到对应的 t 值
    for i = 1:length(s_values)
        target_length = s_values(i) * total_length;
        t_values(i) = find_t_newton(target_length, control_points, total_length);
    end

    % 绘制曲线和等分点
    figure;
    hold on;
    grid on;

    % 绘制控制多边形
    plot(control_points(:,1), control_points(:,2), 'k--o');

    % 绘制贝塞尔曲线
    t_plot = linspace(0, 1, 200)';
    [x_plot, y_plot] = bezier_curve(t_plot, control_points);
    plot(x_plot, y_plot, 'b-', 'LineWidth', 2);

    % 绘制等分点
    [x_points, y_points] = bezier_curve(t_values(:), control_points);
    plot(x_points, y_points, 'ro', 'MarkerSize', 8);

    title('Custom Bezier Curve with Equal Arc Length Partitions');
    xlabel('x');
    ylabel('y');
    axis equal;

    % 添加动画演示
    animate_motion(t_values, control_points);
end

function [x, y] = bezier_curve(t, control_points)
    % 确保 t 是列向量
    t = t(:);
    % 三次贝塞尔曲线公式
    B = [(1-t).^3, 3*t.*(1-t).^2, 3*t.^2.*(1-t), t.^3];
    x = B * control_points(:,1);
    y = B * control_points(:,2);
end

function [dx, dy] = bezier_derivative(t, control_points)
    % 计算导数
    t = t(1);  % 确保t是标量
    % 导数的 Bézier 矩阵公式
    dB = [-3*(1-t)^2, 3*(1-4*t+3*t^2), 3*(2*t-3*t^2), 3*t^2];
    dx = dB * control_points(:,1);
    dy = dB * control_points(:,2);
end

function v = compute_velocity(t, control_points)
    [dx, dy] = bezier_derivative(t, control_points);
    v = sqrt(dx^2 + dy^2);
end

function len = compute_arc_length(t_end, control_points)
    % 使用自适应Simpson求积法计算弧长
    tol = 1e-8;  % 误差容限
    len = adaptive_quad(@(t) compute_velocity(t, control_points), 0, t_end, tol);
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
    
    % 比较精度
    if abs(S1 + S2 - S) <= 15*tol
        integral = S1 + S2;
    else
        % 递归细分区间
        integral = adaptive_quad_recursive(f, a, c, tol/2, S1, fa, fd, fc) + ...
                  adaptive_quad_recursive(f, c, b, tol/2, S2, fc, fe, fb);
    end
end

function t = find_t_newton(target_length, control_points, total_length)
    % 使用牛顿法找到对应的参数 t
    t = target_length / total_length;  % 初始猜测
    tol = 1e-6;
    max_iter = 50;

    for i = 1:max_iter
        current_length = compute_arc_length(t, control_points);
        f = current_length - target_length;
        df = compute_velocity(t, control_points);

        if df == 0
            warning('牛顿法：零导数，无法收敛');
            return;
        end

        t_new = t - f / df;

        % 确保 t_new 在 [0, 1] 范围内
        if t_new < 0
            t_new = 0;
        elseif t_new > 1
            t_new = 1;
        end

        if abs(t_new - t) < tol
            t = t_new;
            return;
        end
        t = t_new;
    end

    warning('牛顿法未能在最大迭代次数内收敛');
end

function animate_motion(t_values, control_points)
    % 创建动画对象
    ball = plot(0, 0, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

    % 动画循环
    for t = linspace(0, 1, 200)
        [x, y] = bezier_curve(t, control_points);
        set(ball, 'XData', x, 'YData', y);
        drawnow;
        pause(0.01);
    end
end