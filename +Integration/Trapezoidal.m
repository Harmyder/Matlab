function Int = Trapezoidal(f, a, b, h)
    n = (b - a) / h;
    y = f(linspace(a, b, n + 1));
    sum_y = sum(y) - 0.5 * (y(1) + y(end));
    Int = sum_y * h;
end