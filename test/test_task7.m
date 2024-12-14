function test_task7()
    fprintf('测试任务7：进度曲线\n');
    
    % 调用主函数展示结果
    try
        task7_progress_curve();
        fprintf('请观察不同进度曲线下的运动效果：\n');
        fprintf('1. 线性（匀速）\n');
        fprintf('2. 三次根（开始快，后面慢）\n');
        fprintf('3. 平方（开始慢，后面快）\n');
        fprintf('4. 正弦（平滑加减速）\n');
        fprintf('5. 复合正弦（中间停顿）\n');
        pause(10);  % 给用户10秒观察时间，因为有5个子图
        close all;
        fprintf('任务7测试通过！\n\n');
    catch e
        close all;
        rethrow(e);
    end
end 