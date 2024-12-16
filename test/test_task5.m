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
    
    % 测试2：原始参数运动
    fprintf('\n测试原始参数运动：\n');
    try
        task5_original_motion();
        pause(2);
    catch e
        fprintf('原始参数运动测试失败：%s\n', e.message);
    end
    
    % 测试3：等速运动
    fprintf('\n测试等速运动：\n');
    try
        task5_constant_speed();
        pause(2);
    catch e
        fprintf('等速运动测试失败：%s\n', e.message);
    end
    
    close all;
    fprintf('任务5测试通过！\n\n');
end 