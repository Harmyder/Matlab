function sc_PlotLagrange()
    for n = 3:20
        PlotRunge(n);
        axis([-2 2 -2 2]);
        axis square;
        pause(.3);
    end

    function PlotRunge(n)
        sampleX = -1:2/n:1;
        f = @(x) 1 ./ (1 + 25 * x.^2);
        sampleY = f(sampleX);

        x = -1:2/(4*n):1;
        y = Lagrange(x, sampleX, sampleY);

        plot(x, y);
        hold on
        plot(x, f(x), 'green');
        hold off
    end
    
end