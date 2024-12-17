function [dx, dy] = bezier_derivative(t, control_points)
    % 计算贝塞尔曲线的导数
    t = t(:);  % 确保t是列向量
    
    % 计算导数的基函数
    dB = [-3*(1-t).^2, 3*(1-4*t+3*t.^2), 3*(2*t-3*t.^2), 3*t.^2];
    
    % 计算x和y方向的导数
    dx = dB * control_points(:,1);
    dy = dB * control_points(:,2);
end 