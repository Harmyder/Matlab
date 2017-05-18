function TestAdamsBashfort()
    method = @(a, b, c, d, e) AdamsBashfort(a, b, c, d, e);
    TestMethod(method);
end