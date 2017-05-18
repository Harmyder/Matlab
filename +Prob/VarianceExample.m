function VarianceExample

    hold on
    
    p1 = Prob.DrawBinomial(10,  0.7, 'c');
    p2 = Prob.DrawBinomial(50,  0.7, 'm');
    p3 = Prob.DrawBinomial(100, 0.7, 'g');

    xlabel('x = k/n');
    ylabel('b(nx)');
    
    legend ([p1, p2, p3], 'n = 10', 'n = 50', 'n = 100','Location','northwest');
    text(0.7, 0.3, 'p = 0.7', 'Color', 'black');

    hold off
end

