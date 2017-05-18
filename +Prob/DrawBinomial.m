function pPoints = DrawBinomial( n, p, color )
% Draws binomial for success probability p

    results = ones(1, n + 1);
    for i = 0:n
        value = nchoosek(n, i);
        results(i + 1) = value * p ^ i * (1 - p) ^ (n - i);
    end

    pPoints = plot (linspace(0,1,n+1), results, strcat(color, '.'), 'MarkerSize',14);
    for i = 0:n
        line([i/n i/n], [0, results(i + 1)], 'LineWidth', 2, 'Color', color);
    end
end

