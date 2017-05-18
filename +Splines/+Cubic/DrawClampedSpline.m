function DrawClampedSpline(x, y, alpha, beta)
    n = size(x, 2)-1;
    h = x(2:n+1) - x(1:n);
    maindiag = [h(1) h(1:n-1) + h(2:n) h(n)];
    A = 2 * diag(maindiag) + diag(h(1:n), -1) + diag(h(1:n), 1);
    z = 3 * ((y(3:n+1) - y(2:n)) ./ h(2:n) - (y(2:n) - y(1:n-1)) ./ h(1:n-1));
    zbegin = 3 * (y(2) - y(1)) / h(1) - 3 * alpha;
    zend = beta - 3 * (y(n+1) - y(n)) / h(n);
    z = [zbegin z zend];
    c = (A\z')';
    b = (y(2:n+1) - y(1:n)) ./ h(1:n) - (2*c(1:n) + c(2:n+1)) .* h(1:n) / 3;
    d = (c(2:n+1) - c(1:n)) ./ h(1:n) / 3;
    a = y;
    
    hold on
    for j = 1:n
        x_out = linspace(0, x(j+1)-x(j), 21);
        y_out = a(j) + b(j) * x_out + c(j) * x_out.^2 + d(j) * x_out.^3;
        plot(x_out + x(j), y_out, 'g');
    end
    plot(x, y, '*g');
    
    plot([x(1) x(1)+5], [y(1) y(1) + alpha*5], 'r');
    hold off    
end