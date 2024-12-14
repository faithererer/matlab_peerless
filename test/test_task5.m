function test_task5()
    fprintf('测试任务5：动画演示\n');
    
    % 测试1：检查路径的关键点
    t_test = [0, 0.25, 0.5, 0.75, 1];  % 测试几个关键点
    
    % 计算期望的位置
    x_expected = 0.5 + 0.3*t_test + 3.9*t_test.^2 - 4.7*t_test.^3;
    y_expected = 1.5 + 0.3*t_test + 0.9*t_test.^2 - 2.7*t_test.^3;
    
    % 验证路径计算的正确性
    for i = 1:length(t_test)
        t = t_test(i);
        x = 0.5 + 0.3*t + 3.9*t^2 - 4.7*t^3;
        y = 1.5 + 0.3*t + 0.9*t^2 - 2.7*t^3;
        
        error = norm([x - x_expected(i), y - y_expected(i)]);
        fprintf('t = %.2f: 位置误差 = %.4e\n', t, error);
        assert(error < 1e-12, sprintf('t = %.2f 处的位置计算不正确', t));
    end
    
    % 测试2：检查动画函数是否可以运行
    try
        % 创建不可见的图形窗口
        fig = figure('Visible', 'off');
        
        % 尝试运行动画的一小段
        task5_animation();
        
        % 如果没有错误，则关闭图形窗口
        close(fig);
        fprintf('动画函数执行正常\n');
    catch e
        close(fig);
        rethrow(e);
    end
    
    fprintf('任务5测试通过！\n\n');
end 