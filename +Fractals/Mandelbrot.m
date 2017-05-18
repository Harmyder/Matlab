function Mandelbrot
    X = -1:0.001:1;
    Y = (-1:0.001:1)';
    n = length(X);
    e = ones(n,1);
    z0 = X(e,:) + i*Y(:,e);
    z = zeros(n,n);
    c = zeros(n,n);
    
    depth = 32;
    for k = 1:depth
        z = z.^2 + z0;
        c(abs(z) < 2) = k;
    end
    
    image(c);
    axis image
    colormap(jet(depth));
end