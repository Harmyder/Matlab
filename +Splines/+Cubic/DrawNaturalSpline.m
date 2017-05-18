function DrawNaturalSpline(x, y)
    n = size(x, 2)-1;
    h = x(2:n+1) - x(1:n);
    A = 2 * diag(h(1:n-1) + h(2:n)) + diag(h(2:n-1), -1) + diag(h(2:n-1), 1);
    z = 3 * ((y(3:n+1) - y(2:n)) ./ h(2:n) - (y(2:n) - y(1:n-1)) ./ h(1:n-1));
    c = zeros(1, n+1);
    c(2:n) = (A\z')';
    b = (y(2:n+1) - y(1:n)) ./ h(1:n) - (2*c(1:n) + c(2:n+1)) .* h(1:n) / 3;
    d = (c(2:n+1) - c(1:n)) ./ h(1:n) / 3;
    a = y;
    
    hold on
    for j = 1:n
        x_out = linspace(0, x(j+1)-x(j), 21);
        y_out = a(j) + b(j) * x_out + c(j) * x_out.^2 + d(j) * x_out.^3;
        plot(x_out + x(j), y_out);
    end
    plot(x, y, '*');
    hold off
end