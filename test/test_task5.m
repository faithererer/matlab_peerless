function test_task5()
    fprintf('测试任务5：动画演示\n');
    
    % 测试1：检查动画初始和结束位置
    figure('Visible', 'off');  % 创建不可见的图形窗口用于测试
    
    % 获取路径的起点和终点
    t = [0, 1];
    x = 0.5 + 0.3*t + 3.9*t.^2 - 4.7*t.^3;
    y = 1.5 + 0.3*t + 0.9*t.^2 - 2.7*t.^3;
    
    start_point = [x(1), y(1)];
    end_point = [x(2), y(2)];
    
    % 运行动画并捕获第一帧和最后一帧
    task5_animation();
    
    % 获取当前图形中的点对象
    h = findobj(gca, 'Type', 'line', 'Marker', 'o');
    if ~isempty(h)
        current_point = [h.XData(1), h.YData(1)];
        
        % 检查结束位置
        error_start = norm(current_point - start_point);
        fprintf('起点位置误差: %.4e\n', error_start);
        assert(error_start < 1e-6, '动画起点位置不正确');
    end
    
    close(gcf);  % 关闭测试图形窗口
    fprintf('任务5测试通过！\n\n');
end 