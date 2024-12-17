function test_task6()
    fprintf('测试任务6：自定义贝塞尔曲线\n');
    
    % 调用主函数展示结果
    try
        task6_custom_bezier();
        fprintf('请观察贝塞尔曲线、等分点和动画效果\n');
        pause(5);  % 给用户足够时间观察动画
        close all;
        fprintf('任务6测试通过！\n\n');
    catch e
        close all;
        fprintf('任务6测试失败：%s\n', e.message);
        rethrow(e);
    end
end 