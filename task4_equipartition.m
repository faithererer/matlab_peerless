function task4_equipartition(n)
    % 计算等分点
    s_values = linspace(0, 1, n+1);
    t_values = zeros(size(s_values));
    
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