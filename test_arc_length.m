function test_arc_length()
    % 定义控制点
    control_points = [
        0, 0;    % P0
        1, 2;    % P1
        2, -1;   % P2
        3, 1     % P3
    ];
    
    % 测试不同t值的弧长
    t_test = [0.2, 0.4, 0.6, 0.8];
    for i = 1:length(t_test)
        len = compute_arc_length(t_test(i), control_points);
        fprintf('t = %.1f, 弧长 = %.4f\n', t_test(i), len);
    end
    
    % 测试相邻段的弧长差异
    n = 20;
    s_values = linspace(0, 1, n+1);
    t_values = zeros(size(s_values));
    for i = 1:length(s_values)
        t_values(i) = find_t_newton(s_values(i), control_points);
    end
    
    total_length = compute_arc_length(1, control_points);
    segment_lengths = zeros(n, 1);
    for i = 1:n
        len = compute_arc_length(t_values(i+1), control_points) - ...
              compute_arc_length(t_values(i), control_points);
        segment_lengths(i) = len;
        fprintf('段 %d: 长度 = %.4f, 比例 = %.4f\n', ...
            i, len, len/total_length);
    end
    
    % 计算长度变异系数
    cv = std(segment_lengths)/mean(segment_lengths);
    fprintf('长度变异系数: %.4f\n', cv);
end 