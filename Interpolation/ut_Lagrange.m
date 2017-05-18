function ut_Lagrange()
    x = [1 1.5 2 2.5 3];
    sampleX = [1 2 3];
    sampleY = [1 4 9];
    f = @(x) x.^2;
    singleUT(x, sampleX, sampleY, f);
    
    sampleY = [1 8 27];
    f = @(x) 6*x.^2 - 11*x + 6;
    singleUT(x, sampleX, sampleY, f);
    
    
    function singleUT(x, sampleX, sampleY, f)
        actual = Lagrange(x, sampleX, sampleY);
        expected = f(x);
        for i = 1:length(x)
            if actual(i) ~= expected(i)
                fprintf('FAIL %d: for %f expected %f, but actual is %f\n', i, x(i), expected(i), actual(i));
            else
                fprintf('SUCCESS %d: for %f expected %f and actual is %f\n', i, x(i), expected(i), actual(i));
            end
        end
    end
end