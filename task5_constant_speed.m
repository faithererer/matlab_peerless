function task5_constant_speed()
    % 创建输出目录（如果不存在）
    if ~exist('out', 'dir')
        mkdir('out');
    end
    
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
    
    % 获取第一帧并确定视频大小
    drawnow;
    frame = getframe(fig);
    [height, width, ~] = size(frame.cdata);
    
    % 创建视频写入对象
    v = VideoWriter(fullfile('out', 'constant_speed.avi'));
    v.FrameRate = 20;
    v.Quality = 100;
    open(v);
    writeVideo(v, frame);  % 写入第一帧
    
    % 等速运动
    title('Motion with Constant Speed');
    for s = linspace(0, 1, 50)
        % 找到对应的参数t
        t = task2_find_t(s);
        
        % 计算位置
        x = 0.5 + 0.3*t + 3.9*t^2 - 4.7*t^3;
        y = 1.5 + 0.3*t + 0.9*t^2 - 2.7*t^3;
        
        % 使用题目要求的命令更新位置
        set(ball, 'xdata', x, 'ydata', y);
        drawnow;
        
        % 捕获当前帧并写入视频
        frame = getframe(fig);
        if size(frame.cdata, 1) ~= height || size(frame.cdata, 2) ~= width
            frame.cdata = imresize(frame.cdata, [height width]);
        end
        writeVideo(v, frame);
        
        pause(0.05);
    end
    
    % 关闭视频文件
    close(v);
    fprintf('动画已保存到 out/constant_speed.avi\n');
end 