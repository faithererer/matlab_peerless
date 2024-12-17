function test_task6()
    fprintf('测试任务6：自定义贝塞尔曲线\n');
    
    % 测试1：检查贝塞尔曲线的关键点
    control_points = [
        0, 0;    % P0
        1, 2;    % P1
        2, -1;   % P2
        3, 1     % P3
    ];
    
    % 检查端点
    [x0, y0] = bezier_curve(0, control_points);
    [x1, y1] = bezier_curve(1, control_points);
    
    fprintf('检查端点：\n');
    fprintf('起点误差 = %.4e\n', norm([x0, y0] - control_points(1,:)));
    fprintf('终点误差 = %.4e\n', norm([x1, y1] - control_points(4,:)));
    
    % 测试2：等分和动画演示
    fprintf('\n测试等分和动画：\n');
    try
        % 创建新的figure
        figure('Name', '自定义贝塞尔曲线');
        task6_custom_bezier();
        pause(5);  % 给足时间观察动画
        
        close all;
        fprintf('动画演示完成\n');
    catch e
        close all;
        fprintf('动画演示失败：%s\n', e.message);
        rethrow(e);
    end
    
    fprintf('任务6测试通过！\n\n');
end 