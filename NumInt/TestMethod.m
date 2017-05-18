function TestMethod(method)
    f = @(x, y) -y^2;
    a = 0; b = 10;
    [x01, y01] = method(f, a, b, 1, 10/0.1);
    [x02, y02] = method(f, a, b, 1, 10/0.2);
    [x04, y04] = method(f, a, b, 1, 10/0.4);
    
    x = linspace(0, 10, 10/0.1);
    F = @(x) (x+1).^-1;
    y = F(x);
    subplot(2, 1, 1);
    plot(x01, y01, x02, y02, x04, y04, x, y);
    axis([a b -6 6])
    legend('0.1', '0.2', '0.4', 'exact');
    
    subplot(2, 1, 2);
    plot(x01, F(x01) - y01, x02, F(x02) - y02, x04, F(x04) - y04);
    axis([a b -6 6])
    title('Error');
    legend('0.1', '0.2', '0.4');
end