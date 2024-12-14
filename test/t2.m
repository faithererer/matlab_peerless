% 测试特定比例的参数查找
test_points = [0.25, 0.5, 0.75];
fprintf('测试不同比例的参数查找：\n');
for s = test_points
    t = task2_find_t(s);
    fprintf('s = %.2f, 找到的t = %.6f\n', s, t);
    
    % 验证找到的参数是否正确
    total_length = task1_arc_length(1);
    current_length = task1_arc_length(t);
    ratio = current_length/total_length;
    assert(abs(ratio - s) < 1e-3, '参数查找错误：比例不匹配');
end
fprintf('参数查找测试通过\n');