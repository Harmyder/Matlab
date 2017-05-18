function TestMidpoint()
    method = @(a, b, c, d, e) Midpoint(a, b, c, d, e);
    TestMethod(method);
end