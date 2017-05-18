function Spacewar(x, y, h)
    plot(x, y, '.', 'markersize', 3);
    hold on
    n = fix(4*pi / h);
    for k = 1:n
        xold = x;
        x = x - y * h;        
        y = y + xold * h;
        plot(x, y, '.', 'markersize', 3);
    end
    hold off
end