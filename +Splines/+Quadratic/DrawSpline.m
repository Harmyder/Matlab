function DrawSpline(x, y, alpha)
    n = size(x, 2) - 1;
    h = x(2:n+1) - x(1:n);
    a = y;
    z = (y(2:n+1) - y(1:n)) ./ h;
    z = [(0.5*alpha) z];
    A = toeplitz([0.5 0.5 zeros(1, n-1)], [0.5 zeros(1, n)]);
    b = (A\z')';
    c = (b(2:n+1) - b(1:n)) ./ h / 2;

    hold on
    for j = 1:n
        x_out = linspace(0, x(j+1)-x(j), 21);
        y_out = a(j) + b(j) * x_out + c(j) * x_out.^2;
        plot(x_out + x(j), y_out);
    end
    plot([x(1) x(1)+5], [y(1) y(1) + alpha*5], 'r');
    plot(x, y, '*');
    hold off
end