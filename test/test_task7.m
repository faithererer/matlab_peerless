function test_task7()
    fprintf('测试任务7：进度曲线\n');
    
    % 测试1：检查进度曲线的值域
    test_progress_curves();
    
    % 测试2：运行动画演示
    try
        task7_progress_curve();
        fprintf('请观察不同进度曲线的运动效果\n');
        pause(5);
        close all;
        fprintf('任务7测试通过！\n\n');
    catch e
        close all;
        fprintf('任务7测试失败：%s\n', e.message);
        rethrow(e);
    end
end

function test_progress_curves()
    % 定义进度曲线
    curves = {
        @(s) s^(1/3),                                  % 三次根曲线
        @(s) s^2,                                      % 平方曲线
        @(s) sin(pi*s/2),                             % 正弦曲线
        @(s) 0.5 + 0.5*sin((2*s-1)*pi/2)             % 复合正弦曲线
    };
    
    % 测试点
    s_test = [0, 0.25, 0.5, 0.75, 1];
    
    % 检查每个曲线
    for i = 1:length(curves)
        fprintf('测试进度曲线 %d:\n', i);
        for s = s_test
            y = curves{i}(s);
            fprintf('  s = %.2f, y = %.4f\n', s, y);
            % 检查值域是否在[0,1]范围内
            assert(y >= 0 && y <= 1, '进度值超出[0,1]范围');
        end
    end
end 