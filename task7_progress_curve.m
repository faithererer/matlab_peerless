% Task 7: Traverse the path according to arbitrary progress curves
% 题目7：根据任意进度曲线遍历路径

function task7_progress_curve()
    % 创建新的figure
    figure;
    
    % 设置图形窗口
    set(gca, 'XLim', [-0.5 2.5], 'YLim', [-0.5 2.5], ...
        'Drawmode', 'fast', 'Visible', 'on');
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
    
    % 定义不同的进度曲线
    progress_curves = {
        @(s) s^(1/3),                                  % 三次根曲线：起始快末尾慢
        @(s) s^2,                                      % 平方曲线：起始慢末尾快
        @(s) sin(pi*s/2),                             % 正弦曲线：平滑加减速
        @(s) 0.5 + 0.5*sin((2*s-1)*pi/2)             % 复合正弦曲线：中间停顿
    };
    
    curve_names = {
        'Cube Root Curve (Fast Start, Slow End)',
        'Square Curve (Slow Start, Fast End)',
        'Sine Curve (Smooth Acceleration)',
        'Composite Sine Curve (Middle Pause)'
    };
    
    % 对每种进度曲线进行演示
    for i = 1:length(progress_curves)
        title(curve_names{i});
        
        % 重置运动点位置
        set(ball, 'xdata', x_plot(1), 'ydata', y_plot(1));
        
        % 按照当前进度曲线运动
        for u = linspace(0, 1, 50)
            % 计算当前进度
            s = progress_curves{i}(u);
            
            % 找到对应的参数t
            t = task2_find_t(s);
            
            % 计算位置
            x = 0.5 + 0.3*t + 3.9*t^2 - 4.7*t^3;
            y = 1.5 + 0.3*t + 0.9*t^2 - 2.7*t^3;
            
            % 使用题目要求的命令更新位置
            set(ball, 'xdata', x, 'ydata', y);
            drawnow;
            pause(0.05);
        end
        
        % 暂停一会儿再显示下一种运动
        pause(1);
    end
end 