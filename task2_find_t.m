% Task 2: Write a program that finds t*(s) for any input s between 0 and 1
% 题目2：编写程序，对于0到1之间的任意输入s，找到路径上对应的参数t*(s)

function t_star = task2_find_t(s)
    % 计算总弧长
    total_length = task1_arc_length(1);
    
    % 目标弧长
    target_length = s * total_length;
    
    % 使用二分法求解
    t_left = 0;
    t_right = 1;
    tol = 1e-3;  % 要求三位小数精度
    
    while (t_right - t_left) > tol
        t_mid = (t_left + t_right)/2;
        current_length = task1_arc_length(t_mid);
        
        if current_length < target_length
            t_left = t_mid;
        else
            t_right = t_mid;
        end
    end
    
    t_star = (t_left + t_right)/2;
end

function f = objective_function(t, s, total_length)
    % 被求零点的函数：当前弧长与目标弧长的差
    current_length = task1_arc_length(t);
    f = current_length - s * total_length;
end 