% Task 3: Equipartition the path into n subpaths of equal length
% 题目3：将路径等分为n段等长的子路径

function task3_equipartition(n)
    % 计算等分点
    s_values = linspace(0, 1, n+1);
    t_values = zeros(size(s_values));
    
    % 对每个s计算对应的t值，使用更高精度的二分法
    for i = 1:length(s_values)
        t_values(i) = find_t_precise(s_values(i));
    end
    
    % 绘制路径和等分点
    t_plot = linspace(0, 1, 100);
    x_plot = 0.5 + 0.3*t_plot + 3.9*t_plot.^2 - 4.7*t_plot.^3;
    y_plot = 1.5 + 0.3*t_plot + 0.9*t_plot.^2 - 2.7*t_plot.^3;
    
    % 计算等分点的坐标
    x_points = 0.5 + 0.3*t_values + 3.9*t_values.^2 - 4.7*t_values.^3;
    y_points = 1.5 + 0.3*t_values + 0.9*t_values.^2 - 2.7*t_values.^3;
    
    % 绘图
    figure;
    plot(x_plot, y_plot, 'b-', 'LineWidth', 1);
    hold on;
    plot(x_points, y_points, 'ro', 'MarkerSize', 8);
    grid on;
    title(['Path Equipartitioned into ' num2str(n) ' Segments']);
    xlabel('x');
    ylabel('y');
end

function t = find_t_precise(s)
    % 使用更高精度的二分法找到对应的参数t
    total_length = task1_arc_length(1);
    target_length = s * total_length;
    
    t_left = 0;
    t_right = 1;
    tol = 1e-10;  % 使用更高的精度
    
    while (t_right - t_left) > tol
        t_mid = (t_left + t_right)/2;
        current_length = task1_arc_length(t_mid);
        
        if current_length < target_length
            t_left = t_mid;
        else
            t_right = t_mid;
        end
    end
    
    t = (t_left + t_right)/2;
end 