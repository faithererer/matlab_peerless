% Task 7: Traverse the path according to arbitrary progress curves
% 题目7：根据任意进度曲线遍历路径

function task7_progress_curve
    % 定义不同的进度曲线
    progress_curves = {
        @(s) s,                    % 线性（匀速）
        @(s) s.^(1/3),            % 三次根
        @(s) s.^2,                % 平方
        @(s) sin(pi*s/2),         % 正弦
        @(s) 1/2 + (1/2)*sin((2*s-1)*pi/2)  % 复合正弦
    };
    
    curve_names = {'Linear', 'Cube Root', 'Square', 'Sine', 'Complex Sine'};
    
    % 为每个进度曲线创建子图
    figure('Position', [100 100 1200 800]);
    
    for i = 1:length(progress_curves)
        subplot(2, 3, i);
        animate_with_progress(progress_curves{i}, curve_names{i});
    end
end

function animate_with_progress(progress_curve, curve_name)
    % 设置图形
    set(gca, 'XLim', [-0.5 2.5], 'YLim', [-0.5 2.5]);
    axis square;
    grid on;
    hold on;
    
    % 绘制基准路径
    t_plot = linspace(0, 1, 100);
    x_plot = 0.5 + 0.3*t_plot + 3.9*t_plot.^2 - 4.7*t_plot.^3;
    y_plot = 1.5 + 0.3*t_plot + 0.9*t_plot.^2 - 2.7*t_plot.^3;
    plot(x_plot, y_plot, 'b-', 'LineWidth', 1);
    
    % 创建运动点
    ball = plot(0, 0, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    title([curve_name ' Progress']);
    
    % 根据进度曲线进行动画
    for s = linspace(0, 1, 100)
        % 计算当前进度
        progress = progress_curve(s);
        % 找到对应的参数t
        t = task2_find_t(progress);
        % 计算位置
        x = 0.5 + 0.3*t + 3.9*t^2 - 4.7*t^3;
        y = 1.5 + 0.3*t + 0.9*t^2 - 2.7*t^3;
        % 更新位置
        set(ball, 'XData', x, 'YData', y);
        drawnow;
        pause(0.01);
    end
end 