function test_task4()
    fprintf('测试任务4：牛顿法实现\n');
    
    % 测试1：比较牛顿法和二分法的结果
    test_points = [0.25, 0.5, 0.75];
    tol = 1e-3;
    
    for i = 1:length(test_points)
        s = test_points(i);
        t_bisection = task2_find_t(s);
        t_newton = task4_newton_method(s);
        error = abs(t_newton - t_bisection);
        
        fprintf('s = %.2f: 二分法 = %.4f, 牛顿法 = %.4f, 差异 = %.4e\n', ...
            s, t_bisection, t_newton, error);
        
        assert(error < tol, sprintf('s = %.2f 处牛顿法结果与二分法差异过大', s));
    end
    
    % 测试2：验证牛顿法的收敛速度
    s = 0.5;
    tic;
    task2_find_t(s);  % 二分法
    t_bisection = toc;
    
    tic;
    task4_newton_method(s);  % 牛顿法
    t_newton = toc;
    
    fprintf('计算时间比较 (s=0.5):\n');
    fprintf('二分法: %.4f秒\n', t_bisection);
    fprintf('牛顿法: %.4f秒\n', t_newton);
    
    fprintf('任务4测试通过！\n\n');
end 