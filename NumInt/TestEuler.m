function TestEuler()
    for i = 1:10
        fprime = @(x, y) -5*y;
        f = @(x) exp(-5*x);
        a = 0;
        b = 3;
        h = 0.05 * i;
        y0 = 1;
        y_f = Euler(fprime, a, b, y0, h);
        y_b = Euler(fprime, a, b, y0, h, 'backward');
        y_m = Euler(fprime, a, b, y0, h, 'modified');
        x = linspace(a, b, round((b - a) / h) + 1);
        x_real = linspace(a, b, (b - a) / 0.1 + 1);
        y_real = f(x_real);
        plot(x, y_f, x, y_b, x, y_m, x_real, y_real);
        legend('Euler', 'backward', 'modified', 'exact solution', 'Location', 'northeast');
        axis([a b -6 6])
        drawnow
        pause(0.1);
    end
end