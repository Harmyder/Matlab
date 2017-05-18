function DrawStabilityZone()
    [X, Y] = meshgrid(-3:0.1:3, -3:0.1:3);
    W = X + i*Y;
    G = 1 + W + W.^2 / 2 + W.^3 / 6 + W.^4 / 24;
    %G = 1 + W;
    contour(X, Y, abs(G), 0:0.0005:1);
    axis square;
    xL = xlim;
    yL = ylim;
    line([0 0], yL, 'Color', [0 0 0]);
    line(xL, [0 0], 'Color', [0 0 0]);
end