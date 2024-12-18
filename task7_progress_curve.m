% Task 7: Traverse the path according to arbitrary progress curves
% 题目7：根据任意进度曲线遍历路径

function task7_progress_curve()
    % 创建输出目录（如果不存在）
    if ~exist('out', 'dir')
        mkdir('out');
    end
    
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
    
    video_names = {
        'cube_root_motion.avi',
        'square_motion.avi',
        'sine_motion.avi',
        'composite_sine_motion.avi'
    };
    
    % 对每种进度曲线进行演示
    for i = 1:length(progress_curves)
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
        
        % 设置标题
        title(curve_names{i});
        
        % 获取第一帧并确定视频大小
        drawnow;
        frame = getframe(fig);
        [height, width, ~] = size(frame.cdata);
        
        % 创建视频写入对象
        v = VideoWriter(fullfile('out', video_names{i}));
        v.FrameRate = 20;
        v.Quality = 100;
        open(v);
        writeVideo(v, frame);  % 写入第一帧
        
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
            
            % 捕获当前帧并写入视频
            frame = getframe(fig);
            if size(frame.cdata, 1) ~= height || size(frame.cdata, 2) ~= width
                frame.cdata = imresize(frame.cdata, [height width]);
            end
            writeVideo(v, frame);
            
            pause(0.05);
        end
        
        % 捕获最后几帧
        for k = 1:20
            frame = getframe(fig);
            if size(frame.cdata, 1) ~= height || size(frame.cdata, 2) ~= width
                frame.cdata = imresize(frame.cdata, [height width]);
            end
            writeVideo(v, frame);
        end
        
        % 关闭视频文件
        close(v);
        fprintf('动画已保存到 out/%s\n', video_names{i});
        
        % 关闭当前figure
        close(fig);
    end
end 