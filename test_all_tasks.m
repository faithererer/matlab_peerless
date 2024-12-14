% 测试所有任务的实现
% Test script for all tasks implementation

function test_all_tasks()
    fprintf('开始测试所有任务...\n\n');
    close all;  % 关闭所有图窗
    %% 测试任务1：弧长计算
    fprintf('测试任务1：弧长计算\n');
    test_arc_length();
    
    %% 测试任务2：参数查找
    fprintf('\n测试任务2：参数查找\n');
    test_parameter_finding();
    
    %% 测试任务3：等分
    fprintf('\n测试任务3：路径等分\n');
    test_equipartition();
    
    %% 测试任务4：牛顿法
    fprintf('\n测试任务4：牛顿法实现\n');
    test_newton_method();
    
    %% 测试任务5：动画
    fprintf('\n测试任务5：动画演示\n');
    test_animation();
    
    %% 测试任务6：自定义贝塞尔曲线
    fprintf('\n测试任务6：自定义贝塞尔曲线\n');
    test_custom_bezier();
    
    %% 测试任务7：进度曲线
    fprintf('\n测试任务7：进度曲线\n');
    test_progress_curves();
end

function test_arc_length()
    % 测试特定点的弧长
    test_points = [0.25, 0.5, 0.75, 1.0];
    fprintf('计算不同参数值的弧长：\n');
    for t = test_points
        len = task1_arc_length(t);
        fprintf('t = %.2f, 弧长 = %.6f\n', t, len);
    end
    
    % 验证弧长的单调性
    len1 = task1_arc_length(0.3);
    len2 = task1_arc_length(0.6);
    assert(len1 < len2, '弧长计算错误：不满足单调性');
    fprintf('弧长单调性测试通过\n');
end

function test_parameter_finding()
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
end

function test_equipartition()
    % 测试两种不同的分段数
    ns = [4, 20];
    for n = ns
        fprintf('测试%d等分：\n', n);
        task3_equipartition(n);
        fprintf('请检查图形显示是否正确\n');
        pause(2);
    end
end

function test_newton_method()
    % 比较牛顿法和二分法的结果
    test_points = [0.25, 0.5, 0.75];
    fprintf('比较牛顿法和二分法：\n');
    for s = test_points
        t_bisection = task2_find_t(s);
        t_newton = task4_newton_method(s);
        fprintf('s = %.2f:\n', s);
        fprintf('  二分法结果: %.6f\n', t_bisection);
        fprintf('  牛顿法结果: %.6f\n', t_newton);
        assert(abs(t_bisection - t_newton) < 1e-2, '牛顿法结果与二分法差异过大');
    end
    fprintf('牛顿法测试通过\n');
end

function test_animation()
    fprintf('开始动画测试...\n');
    task5_animation();
    fprintf('请观察动画是否流畅，运动是否符合预期\n');
    pause(5);
end

function test_custom_bezier()
    fprintf('测试自定义贝塞尔曲线...\n');
    task6_custom_bezier();
    fprintf('请检查曲线形状和等分点是否合理\n');
    pause(5);
end

function test_progress_curves()
    fprintf('测试不同进度曲线...\n');
    task7_progress_curve();
    fprintf('请观察不同进度曲线下的运动特征\n');
    pause(5);
end 