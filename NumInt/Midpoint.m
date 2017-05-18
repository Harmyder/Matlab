function [x, y] = Midpoint(f, a, b, y0, n)
    h = (b - a) / n;
    x = [a NaN(1, n)];
    y = [y0 NaN(1, n)];
    
    % Use forward Euler for the first step
    x(2) = x(1) + h;
    y(2) = y0 + h * f(x(1), y(1));
    
    for i = 3:n+1
        fprime = f(x(i-1), y(i-1));
        y(i) = y(i-2) + 2*h * fprime;
        x(i) = x(i-1) + h;
    end    
end