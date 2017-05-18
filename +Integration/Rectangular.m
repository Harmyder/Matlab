function Int = Rectangular( f, a, b, h )
    n = (b - a) / h;
    y = f(linspace(a, b, n + 1));
    sum_y = sum(y) - y(end);
    Int = sum_y * h;
end

