function task5_original_motion()
    % 创建新的figure并设置固定大小
    fig = figure('Position', [100 100 800 600], 'Units', 'pixels');
    
    % 设置图形窗口
    set(gca, 'XLim', [-0.5 2.5], 'YLim', [-0.5 2.5], ...
        'SortMethod', 'childorder', 'Visible', 'on');
    cla
    axis square
    grid on;
    hold on;
    
    % 绘制完整路径
    t_plot = linspace(0, 1, 100);
    x_plot = 0.5 + 0.3*t_plot + 3.9*t_plot.^2 - 4.7*t_plot.^3;
    y_plot = 1.5 + 0.3*t_plot + 0.9*t_plot.^2 - 2.7*t_plot.^3;
    plot(x_plot, y_plot, 'b-', 'LineWidth', 1);
    
    % 创建运动点
    ball = plot(x_plot(1), y_plot(1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    
    % 原始参数运动
    title('Motion with Original Parameterization');
    for t = linspace(0, 1, 50)
        % 计算当前位置
        x = 0.5 + 0.3*t + 3.9*t^2 - 4.7*t^3;
        y = 1.5 + 0.3*t + 0.9*t^2 - 2.7*t^3;
        
        % 使用题目要求的命令更新位置
        set(ball, 'xdata', x, 'ydata', y);
        drawnow;
        pause(0.05);
    end
end 