function test_task6()
    fprintf('测试任务6：自定义贝塞尔曲线\n');
    
    % 测试1：检查贝塞尔曲线的端点性质
    control_points = [0, 0; 1, 2; 2, -1; 3, 1];
    
    % 检查曲线是否通过端点
    [x0, y0] = bezier_curve(0, control_points);
    [x1, y1] = bezier_curve(1, control_points);
    
    start_error = norm([x0, y0] - control_points(1,:));
    end_error = norm([x1, y1] - control_points(end,:));
    
    fprintf('起点误差: %.4e\n', start_error);
    fprintf('终点误差: %.4e\n', end_error);
    
    assert(start_error < 1e-6, '贝塞尔曲线未通过起点');
    assert(end_error < 1e-6, '贝塞尔曲线未通过终点');
    
    % 测试2：检查弧长计算的单调性
    t_values = linspace(0, 1, 10);
    lengths = zeros(size(t_values));
    for i = 1:length(t_values)
        lengths(i) = compute_arc_length(t_values(i), control_points);
    end
    
    is_monotonic = all(diff(lengths) > 0);
    assert(is_monotonic, '贝塞尔曲线弧长计算不满足单调性');
    
    fprintf('任务6测试通过！\n\n');
end 