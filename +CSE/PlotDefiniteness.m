function PlotDefiniteness(A)
    assert(isequal(A, A'));
    assert(rank(A) == 2);
    
    a = A(1,1);
    b = A(1,2);
    c = A(2,2);
    [x,y] = meshgrid(-10:0.5:10, -10:0.5:10);
    Z = a*x.^2+2*b*x.*y+c*y.^2;
    surf(x,y,Z);

end

