function [] = TEST( n )
    D = 1.5;
    x = linspace(0,D,n+2)';
    denom = (exp(1/D)-1);
    u = -(exp(x/D)-1)/denom;
    x = x(2:n+1);
    u = u(2:n+1);
    K = CSE.KTBC('K', n)
    h = 1 / (n+1);
    u2 = -K/(h^2)*u;
    u2R = -exp(x/D)/(D^2*denom);
    second = [u2 u2R]
    u1f = toeplitz([-1 0 zeros(1, n-2)], [-1 1 zeros(1,n-2)]) / (h) * u;
    u1b = toeplitz([1 -1 zeros(1, n-2)], [1 0 zeros(1,n-2)]) / (h) * u;
    u1c = toeplitz([0 -1 zeros(1, n-2)], [0 1 zeros(1,n-2)]) / (2*h) * u;
    u1R = 1 - exp(x/D)/(D*denom);
    first = [u1f u1b u1c u1R]
    first = [u1f-u1R u1b-u1R u1c-u1R u1R-u1R]
    u1 = u1f
    [-D*u2+u1 -D*u2R+u1R]
    plot(x, u);
end

