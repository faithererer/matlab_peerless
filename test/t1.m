
 
% 测试特定点的弧长
test_points = [0.25, 0.5, 0.75, 1.0];
fprintf('计算不同参数值的弧长：\n');
for t = test_points
    len = task1_arc_length(t);
    fprintf('t = %.2f, 弧长 = %.6f\n', t, len);
end
