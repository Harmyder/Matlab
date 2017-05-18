% v^{n+1} = v^n + \delta t \times (\frac{3}{2}f(v^n, t^n) - \frac{1}{2}f(v^{n-1}, t^{n-1}))
function [x, y] = AdamsBashfort(f, a, b, y0, n)
    h = (b - a) / n;
    x = [a NaN(1, n)];
    y = [y0 NaN(1, n)];
    
    % Use forward Euler for the first step
    x(2) = x(1) + h;
    y(2) = y0 + h * f(x(1), y(1));
    
    for i = 3:n+1
        f_1 = f(x(i-1), y(i-1));
        f_2 = f(x(i-2), y(i-2));
        y(i) = y(i-1) + h * (3/2 * f_1 - 1/2 * f_2);
        x(i) = x(i-1) + h;
    end    

end