% 测试不同比例的参数查找
test_points = [0.25, 0.5, 0.75];
fprintf('测试不同比例的参数查找：\n');

for s = test_points
    % 查找对应的 t
    t = task2_find_t(s);
    
    % 输出 t，并确保精度为三位小数
    fprintf('s = %.2f, 找到的 t = %.3f\n', s, t);
    
    % 验证找到的参数是否正确
    total_length = task1_arc_length(1);  % 计算总弧长
    current_length = task1_arc_length(t);  % 计算当前弧长
    ratio = current_length / total_length;  % 计算比例
    
    % 输出计算的比例，并确保精度为三位小数
    fprintf('    计算的比例 = %.3f\n, 误差 = %.5f\n', ratio, abs(ratio - s));
    
    % 使用 assert 验证比例是否匹配目标比例，允许容差为 1e-3
    assert(abs(ratio - s) < 1e-3, '参数查找错误：比例不匹配');
end

fprintf('参数查找测试通过\n');
