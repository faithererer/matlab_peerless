function test_task7()
    fprintf('测试任务7：进度曲线\n');
    
    % 运行动画演示
    try
        task7_progress_curve();
        fprintf('请观察不同进度曲线的运动效果：\n');
        fprintf('1. 三次根曲线：起始快末尾慢\n');
        fprintf('2. 平方曲线：起始慢末尾快\n');
        fprintf('3. 正弦曲线：平滑加减速\n');
        fprintf('4. 复合正弦曲线：中间停顿\n');
        pause(25);  % 给足时间观察所有四种运动
        close all;
        fprintf('任务7测试通过！\n\n');
    catch e
        close all;
        fprintf('任务7测试失败：%s\n', e.message);
        rethrow(e);
    end
end 