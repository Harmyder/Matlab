function y = Euler(f, a, b, y0, h, type)
    inner_type = 0;
    if nargin == 6
        if strcmp(type, 'backward')
            inner_type = 1;
        elseif strcmp(type, 'modified')
            inner_type = 2;
        end
    end
    n = round((b - a) / h);
    y = [y0 zeros(1, n)];
    for i = 1:n
        t = i*h;
        y(i+1) = y(i) + f(t, y(i))*h;
        if inner_type == 1
            y(i+1) = y(i) + f(t, y(i+1))*h;
        elseif inner_type == 2
            y(i+1) = y(i) + h * (f(t, y(i)) + f(t + h, y(i+1))) / 2;
        end
    end
end