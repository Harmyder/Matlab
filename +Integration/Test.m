function Test(f, a, b)
    h = (ones(1,8)*10).^(-(0:7));
    
    area = integral(f, a, b);
    
    rectangular = arrayfun(@(h_) (abs(area - Integration.Rectangular(f, a, b, h_))), h);
    trapezoidal = arrayfun(@(h_) (abs(area - Integration.Trapezoidal(f, a, b, h_))), h);
    
    figure
    loglog(h, rectangular, 'b*', h, trapezoidal, 'r+');
%    loglog(h, trapezoidal, 'r+');
    legend('rectangular', 'trapezoidal', 'Location', 'northwest');
    xlabel('h');
    ylabel('truncation error');
end