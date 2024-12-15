
 
% 测试特定点的弧长，通过与 MATLAB 库函数比较
test_points = [0.25, 0.5, 0.75, 1.0];
fprintf('计算不同参数值的弧长，并与MATLAB库函数的结果比较：\n');

% 设置容差
tol = 1e-8;

for t = test_points
    % 使用自适应求积法计算弧长
    len_task1 = task1_arc_length(t);
    
    % 使用MATLAB内建的integral函数计算弧长
    % 定义integrand为一个匿名函数
    integrand_func = @(t) sqrt((0.3 + 7.8*t - 14.1*t.^2).^2 + (0.3 + 1.8*t - 8.1*t.^2).^2);
    
    % 使用integral计算弧长，范围从0到t
    len_integral = integral(integrand_func, 0, t, 'AbsTol', tol);
    
    % 输出比较结果
    fprintf('t = %.2f, 自适应求积法计算的弧长 = %.6f, 库函数计算的弧长 = %.6f, 误差 = %.6f\n', ...
            t, len_task1, len_integral, abs(len_task1 - len_integral));
end
