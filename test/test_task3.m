function test_task3()
    fprintf('测试任务3：路径等分\n');
    
    % 测试1：检查等分点的间距是否相等
    n = 10;  % 测试10等分
    s_values = linspace(0, 1, n+1);
    t_values = zeros(size(s_values));
    
    for i = 1:length(s_values)
        t_values(i) = task2_find_t(s_values(i));
    end
    
    % 计算每段的实际弧长
    segment_lengths = zeros(n, 1);
    for i = 1:n
        segment_lengths(i) = task1_arc_length(t_values(i+1)) - task1_arc_length(t_values(i));
    end
    
    % 检查弧长是否相等
    mean_length = mean(segment_lengths);
    max_error = max(abs(segment_lengths - mean_length));
    
    fprintf('最大段长误差: %.4e\n', max_error);
    assert(max_error < 1e-3, '路径等分的段长不均匀');
    
    fprintf('任务3测试通过！\n\n');
end 