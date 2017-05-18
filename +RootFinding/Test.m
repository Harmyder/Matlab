function Test()
    f = @(x) [dot(x,x)-100; x(1)*x(2)*x(3)-1; x(1)-x(2)-sin(x(3))];
    x0 = [5; 4; 2];
%    f = @(x) [dot(x,x)-1; x(2)-sin(x(1))];
%    x0 = [1; 1];
    options = optimset('Display', 'iter', 'TolFun', 1e-6, 'TolX', 1e-12, 'MaxIter', 100);
    x = RootFinding.NewtonRaphson(f, x0, options);
    f(x)
end