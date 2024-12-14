function test_task7()
    fprintf('测试任务7：进度曲线\n');
    
    % 测试1：检查不同进度曲线的边界条件
    progress_curves = {
        @(s) s,                    % 线性
        @(s) s.^(1/3),            % 三次根
        @(s) s.^2,                % 平方
        @(s) sin(pi*s/2),         % 正弦
        @(s) 1/2 + (1/2)*sin((2*s-1)*pi/2)  % 复合正弦
    };
    
    for i = 1:length(progress_curves)
        f = progress_curves{i};
        
        % 检查起点和终点
        start_val = f(0);
        end_val = f(1);
        
        fprintf('进度曲线 %d: f(0) = %.4f, f(1) = %.4f\n', i, start_val, end_val);
        
        assert(abs(start_val) < 1e-6, sprintf('进度曲线 %d 起点不为0', i));
        assert(abs(end_val - 1) < 1e-6, sprintf('进度曲线 %d 终点不为1', i));
    end
    
    % 测试2：检查进度曲线的单调性
    s_values = linspace(0, 1, 100);
    for i = 1:length(progress_curves)
        f = progress_curves{i};
        progress = arrayfun(f, s_values);
        
        is_monotonic = all(diff(progress) >= 0);
        assert(is_monotonic, sprintf('进度曲线 %d 不满足单调性', i));
    end
    
    fprintf('任务7测试通过！\n\n');
end 