% Task 5: Animate the motion along the path
% 题目5：沿路径运动的动画演示

function task5_animation
    % 创建图形窗口
    figure('Position', [100 100 800 600]);
    ax = gca;
    
    % 设置坐标轴
    ax.XLim = [-0.5 2.5];
    ax.YLim = [-0.5 2.5];
    ax.DataAspectRatio = [1 1 1];
    grid on;
    hold on;
    
    % 绘制完整路径
    t_plot = linspace(0, 1, 100);
    x_plot = 0.5 + 0.3*t_plot + 3.9*t_plot.^2 - 4.7*t_plot.^3;
    y_plot = 1.5 + 0.3*t_plot + 0.9*t_plot.^2 - 2.7*t_plot.^3;
    plot(x_plot, y_plot, 'b-', 'LineWidth', 1);
    
    % 创建运动点（使用持久化的图形对象）
    ball = plot(x_plot(1), y_plot(1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    
    % 原始参数速度的动画
    title('Motion with Original Parameterization');
    for t = linspace(0, 1, 100)
        % 计算当前位置
        x = 0.5 + 0.3*t + 3.9*t^2 - 4.7*t^3;
        y = 1.5 + 0.3*t + 0.9*t^2 - 2.7*t^3;
        
        % 更新点的位置
        set(ball, 'XData', x, 'YData', y);
        drawnow;
        pause(0.01);
    end
    pause(1);
    
    % 等速运动的动画
    title('Motion with Constant Speed');
    total_length = task1_arc_length(1);
    
    for s = linspace(0, 1, 100)
        % 找到对应的参数t
        t = task2_find_t(s);
        
        % 计算位置
        x = 0.5 + 0.3*t + 3.9*t^2 - 4.7*t^3;
        y = 1.5 + 0.3*t + 0.9*t^2 - 2.7*t^3;
        
        % 更新点的位置
        set(ball, 'XData', x, 'YData', y);
        drawnow;
        pause(0.01);
    end
end 