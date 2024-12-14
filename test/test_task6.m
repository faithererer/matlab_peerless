function test_task6()
    fprintf('测试任务6：自定义贝塞尔曲线\n');
    
    % 测试1：检查贝塞尔曲线的可视化
    try
        % 创建不可见的图形窗口
        fig = figure('Visible', 'off');
        
        % 运行主函数
        task6_custom_bezier();
        
        % 获取图形中的所有线条对象
        lines = findobj(gca, 'Type', 'line');
        assert(~isempty(lines), '未找到曲线绘制');
        
        % 检查是否绘制了控制多边形和曲线
        line_styles = get(lines, 'LineStyle');
        if ~iscell(line_styles)
            line_styles = {line_styles};
        end
        has_control_polygon = any(strcmp(line_styles, '--'));
        has_curve = any(strcmp(line_styles, '-'));
        
        assert(has_control_polygon, '未绘制控制多边形');
        assert(has_curve, '未绘制贝塞尔曲线');
        
        close(fig);
    catch e
        if exist('fig', 'var')
            close(fig);
        end
        rethrow(e);
    end
    
    % 测试2：检查等分点的数量
    try
        fig = figure('Visible', 'off');
        task6_custom_bezier();
        
        % 检查等分点（红色标记点）
        points = findobj(gca, 'Type', 'line', 'Color', 'r', 'Marker', 'o');
        assert(~isempty(points), '未找到等分点');
        
        % 获取所有红色点的数据
        all_points = [];
        for i = 1:length(points)
            x_data = get(points(i), 'XData');
            if ~isempty(x_data)
                if isscalar(x_data)
                    all_points = [all_points; 1];
                else
                    all_points = [all_points; length(x_data)];
                end
            end
        end
        
        % 验证等分点的总数
        n_points = sum(all_points);
        fprintf('找到 %d 个等分点\n', n_points);
        assert(n_points == 21, sprintf('等分点数量不正确，期望21个点，实际有%d个', n_points));
        
        close(fig);
    catch e
        if exist('fig', 'var')
            close(fig);
        end
        rethrow(e);
    end
    
    % 测试3：检查动画功能
    try
        fig = figure('Visible', 'off');
        task6_custom_bezier();
        close(fig);
        fprintf('动画功能正常\n');
    catch e
        if exist('fig', 'var')
            close(fig);
        end
        rethrow(e);
    end
    
    fprintf('任务6测试通过！\n\n');
end 